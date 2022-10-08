---
title: Serverless Stack の Live Lambda Development の仕組み
date: 2021-10-30 05:06:46
---

[Serverless Stack](https://docs.serverless-stack.com/) という AWS でサーバレスなアプリケーションを作るためのフレームワークが存在します。

CloudFormation や AWS CDK を用いて Lambda をデプロイしようとすると数十秒〜数分かかることが多いと思います。

Serverless Framework には Live Lambda Development という仕組みが存在しています。

この仕組みを活用することによって、ローカルのユニットテストより本番に近い環境 && AWS にデプロイするより早いサイクルで開発を行うことができます。

Live Lambda Development のアイデア
-----------------------------

そもそも何もデプロイしなくて良いならそれが一番早い、と考えることができます。

Live Lambda Development では Lambda とローカルのコードを WebSocket で繋ぐ仕組みを作ることによって、ローカルのコードを変更したときに実際には何もデプロイしていないにも関わらず一瞬でローカルのコードがデプロイされたかのような振る舞いを実現しています。
つまり Lambda 上で動かすためのコードを書いた後、 デバッグ用のコマンド (`sst start`) を実行すると Lambda にはそのコード自体ではなく WebSocket に `event` を流すだけのコードがデプロイされます。
その `event` は WebSocket でローカルマシンに渡されて処理されます。
もちろん本番デプロイ用のコマンド (`sst deploy`)を実行すると自分で書いたコードがそのままデプロイされます。

`sst start` をしたときに起こること
-----------------------

`sst start`は大きく分けて2つの処理を順に行います。

1.  各種 AWS リソースの作成
2.  ローカルマシンで WebSocket の通信を行う仕組みの起動

### 作成される AWS リソースについて

![](https://images.microcms-assets.io/assets/6d557c87790a4d889ca5641b57b7947f/25bfcc31a85145ceb9f27047dd45de13/serverless-stack.jpg)

左の API Gateway (HTTP) と Lambda はアプリケーションのコードが含まれるものです。

その他の S3、 DynamoDB、 中央にある API Gateway (WebSocket) と Lambda はデバッグスタックと呼ばれるもので、本番デプロイのときは使用されません。

まず中央の API Gateway (WebSocket) と Lambda はアプリケーション本体となる Lambda とローカル PC を繋ぐ中間サーバです。

API Gateway (HTTP) 内にある Lambda が直接ローカルマシンと WebSocket で接続することはできません。

API Gateway (HTTP) → ローカルマシンの通信では NAT が問題になり、 ローカルマシン → API Gateway (HTTP) で通信する際は API Gateway が WebSocket と HTTP の両方を listen するように定義できないという仕様が問題なります。

この問題を解決するために API Gateway (WebSocket) が必要になります。

S3 には `event` オブジェクトが入ります。
基本的には `event` は WebSocket のデータとして送られるのですが、 [32kb を超えるサイズのデータは API Gateway では扱えない](https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/limits.html#apigateway-execution-service-websocket-limits-table)ため、そのようなデータは S3 に保存されて WebSocket 上ではそのキーのみをやりとりします。
`event` は `gzip` で圧縮されたバイナリに変換された後、 `base64` でテキストに変換されてやりとりされます。
DynamoDB にはクライアントとのコネクション ID が保持されています。
WebSocket 側の Lambda が HTTP 側の Lambda から `event` を WebSocket で受け取って起動した際、それをクライアント側の WebSocket コネクションに流す必要がありますが、その時点でその Lambda のプロセスがクライアントのコネクションを保持しているとは限らないのでこの情報を永続化する必要があります。
これらのデプロイは AWS CDK (CloudFormation) を使用して行われるため数分待たされてしまうのですが、初回デプロイのみの問題です。

### ローカルマシンで WebSocket の通信を行う仕組み

これは単純です。
[Node.js の ws パッケージ](https://github.com/websockets/ws)で API Gateway と WebSocket のコネクションを貼って `event` が飛んでくるのを待ちます。
`event` が飛んできたらローカルのコードを別プロセスとして起動して、プロセス間通信で処理結果を受け取り、その処理結果を API Gateway に WebSocket で送り返します。

--

HTTPリクエストが発行されてからHTTPレスポンスが返されるまでの流れ
------------------------------------

各要素について説明を行いましたが、まとめると以下のような順で処理が行われるということになります。

-   API Gateway がブラウザから HTTP リクエストを受け付ける
-   HTTP の Lambda は`event` を WebSocket の Lambda に流す
-   ただし `event` が大きすぎる場合は `s3:PutObject` を行い、以降 `event` を渡す場所では S3 のキーを使う
-   WebSocket の Lambda は DynamoDB からコネクション ID を取得し、 `event` をローカルマシンに流す
-   ローカルマシンはローカルのコードを子プロセスとして起動し `event` を渡し処理結果を IPC で受け取る
-   ローカルマシンは IPC で受け取った処理結果を WebSocket の Lambda に送り返す
-   WebSocket の Lambda はローカルマシンから受け取った処理結果を HTTP の Lambda から受け取る
-   HTTP の Lambda はブラウザに処理結果を送る

参考リンク
-----

-   [HTTP の Lambda にデプロイされるコード](https://github.com/serverless-stack/serverless-stack/blob/890a468a6fffafe9e39a53f97b7a30353720cdbc/packages/resources/assets/stub/index.js)
-   [WebSocket の Lambda にデプロイされるコード](https://github.com/serverless-stack/serverless-stack/blob/890a468a6f/packages/cli/assets/debug-stack/lambda/wsDefault.js)
-   [ローカルマシンで起動するコード](https://github.com/serverless-stack/serverless-stack/blob/890a468a6f/packages/cli/scripts/start.js)

終わりに
----

サーバレスのシステムは運用は楽なものの開発は難しいという側面があると思います。
そんな中で最近はこの Serverless Stack だったり AWS CDK の hotswap 機能がリリースされたりしました。
自分も最近 [Amplify 上で hotswap を行うプラグイン](https://github.com/lambdasawa/amplify-function-hotswap-plugin) を実装したりしました。
これを読んだ誰かが開発を楽にする新しいアイデアを思いつたり、それを実装したりするきっかけになれば幸いです。
