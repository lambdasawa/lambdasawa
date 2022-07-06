# CloudWatch Synthetics

<https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html>

いわゆる外形監視を行うことができるサービス。
Puppeteer を使ってアクセスのシナリオを書き、ステータスコードが期待どおりであるか、期待した DOM があるか、スクリーンショットに差分がないかを数分おきにチェックできる。

Synthetics 自体に Slack 通知などの仕組みはない。
代わりに Synthetics の設定をすると CloudWatch Alarm が作成されるので、そのアラームをトリガーにしてメール通知、 Amaozn SNS 通知、 AWS Chatbot (Slack) 連携ができる。

Puppeteer の API とある程度の互換性があるようで、 Puppeteer 上で動くシナリオを少し修正するだけ Synthetics 上でもそのシナリオを動かせる。

<https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/mo….html#CloudWatch_Synthetics_Canaries_modify_puppeteer_script>

Synthetics 上で使えるクラス、関数のリファレンスは以下にある。
<https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library_Nodejs.html>

## 画像の見た目を検証するサンプルコード

一般的なユースケースは HTML を返すページにアクセスしてスクショが想定通りか検証…というものだと思われるが、動的なサイトだと毎回微妙に結果が違ったりするため少し考慮事項が多い。
そのためまずはシンプルに特定の画像 URL にアクセスして、その見た目が変わってないことを検証するコードを考える。

```js
const synthetics = require("Synthetics");

const pageLoad = async function () {
  const config = synthetics.getConfiguration();
  config.withVisualCompareWithBaseRun(true);
  config.withVisualVarianceHighlightHexColor("#ff0000");
  config.withVisualVarianceThresholdPercentage(10); // 画像の見た目が多少(10%)変わってもエラーにはしない

  const page = await synthetics.getPage();

  const response = await page.goto("https://secure.gravatar.com/avatar/667b2dd89c0c98eb5e8768d7ec1572c9");
  if (response.status() !== 200) {
    throw new Error("Failed to load page!");
  }

  await synthetics.takeScreenshot("me", "loaded");
};

exports.handler = async () => {
  return await pageLoad();
};
```

## API のレスポンスが期待通りであるか検証するサンプルコード

画像の次にシンプルなのが DOM が絡まず単純に API をテストするケース。
自社サービスのバックエンドに `GET /healthcheck` などのエンドポイントが実装されており、そこを監視したい場合などに便利。

今回はテストとして [`POST https://httpbin.org/anything`](https://httpbin.org/#/Anything/post_anything) を叩いてそのレスポンスボディを検証することを考える。

これは [`synthetics.executeHttpStep`](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/mo…ry_Nodejs.html#CloudWatch_Synthetics_Library_executeHttpStep) が使える。

基本的には Node の [`http パッケージの request`](https://nodejs.org/api/http.html#http_http_request_options_callback) と互換性があるインターフェースになっている。
なので `fetch` みたいに丸ごとレスポンスボディを得ることはできなくて、 `res.on("data", (data) => {})` と `res.on("end", () => {})` でレスポンスボディを得る必要がある。
完全に互換性があるわけではないようで、 `http` パッケージであれば  `req.write(data)` としてリクエストボディを書き込むところだが、第2引数のオプションに `body` を渡すことができる。

```js
const synthetics = require("Synthetics");

const pageLoad = async function () {
  return synthetics.executeHttpStep(
    "Test httpbin.org/anything",
    {
      method: "POST",
      protocol: "https:",
      port: "443",
      hostname: "httpbin.org",
      path: "/anything",
      headers: {
        "content-type": "application/json",
        // 任意のヘッダーが書き込めるので認証が必要な場合はここに authorization: "Bearer foo", などと書く
      },
      body: JSON.stringify({ foo: "bar" }),
    },
    (res) => {
      return new Promise((resolve, reject) => {
        if (res.statusCode >= 400) {
          return reject(new Error(`HTTP Status Error: ${res.statusCode}`));
        }

        let responseBody = "";

        res.on("data", (data) => {
          responseBody += data;
        });

        res.on("end", () => {
          const body = JSON.parse(responseBody);
          if (body.json.foo !== "bar") {
            return reject(new Error(`HTTP Response Body Error: ${responseBody}`));
          }

          resolve();
        });
      });
    },
    {
      // AWS のコンソールでリクエストヘッダーを見れるようにする
      includeRequestHeaders: true,
      // AWS のコンソールでレスポンスヘッダーを見れるようにする
      includeResponseHeaders: true,
      // AWS のコンソールでリクエストボディーを見れるようにする
      includeRequestBody: true,
      // AWS のコンソールでレスポンスボディを見れるようにする
      includeResponseBody: true,
      // この API 呼び出しが失敗したときに次のステップに進むかどうか。
      // 複数の API をテストする場合は true にしておくと、どの API が落ちてるか一覧でわかる。
      continueOnHttpStepFailure: true, 
    }
  );
}

exports.handler = async () => {
  return await pageLoad();
};

```

## ブラウザ上で特定の操作をした後の見た目をテスト

どんな Web サービスにもありそうな機能として、ログインを例に考える。
ログインするには ID の入力、パスワードの入力、ログインボタンの押下の3つの操作が必要になる。
これを Puppeteer 上で行うようなコードが以下。

バグなどでログインしたあとのページの見た目が変わっていたらアラートが発火して問題に気づける
もしそれが意図した変更であれば、 Synthetics のページから Canary を編集して「次の実行を新しいベースラインとして設定」をチェックすると次回実行時にアラートが下がる。

```js
const synthetics = require("Synthetics");

const pageLoad = async function () {
  const config = synthetics.getConfiguration();
  
  // ページの見た目をテストする機能を ON にする
  config.withVisualCompareWithBaseRun(true);
  
  // ページの見た目が変わっていたら AWS コンソール上でその差分を #ff0000 色でハイライトする
  config.withVisualVarianceHighlightHexColor("#ff0000");
  
  // ページの見た目が多少(10%)変わってもエラーにはしない
  config.withVisualVarianceThresholdPercentage(10);

  const page = await synthetics.getPage();

  await page.goto("https://app.example.com/signin", { waitUntil: "networkidle0" });
  await page.setViewport({ width: 1200, height: 720 }); // ウィンドウサイズを調整
  await synthetics.takeScreenshot("login", "before"); // ログイン前のスクショ

  {
    const username = process.env.USERNAME || "username";
    await page.waitForSelector('input[type="text"]'); // 期待した Element が描画されるまで待つ
    await page.type('input[type="text"]', username); // ID を入力

    const password = process.env.PASSWORD || "password";
    await page.waitForSelector('input[type="password"]'); // 期待した Element が描画されるまで待つ
    await page.type('input[type="password"]', password); // パスワード を入力

    await synthetics.takeScreenshot("login", "after-type"); // ID,パスワードを入力した後のスクショ
  }

  await page.click("button"); // ログインをボタンを押す
  await page.waitFor(15 * 1000); // 15 秒待つ
  await synthetics.takeScreenshot("login", "after-click"); // ログインボタンを押した後のスクショ
};

exports.handler = async () => {
  return await pageLoad();
};
```
