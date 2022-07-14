# OpenAPI

## spec

<https://swagger.io/specification/>

# viewer

- <https://swagger.io/tools/swagger-ui/>
- <https://redoc.ly/>
- <https://mrin9.github.io/RapiDoc/>

どれも Docker イメージがある。

- <https://hub.docker.com/r/swaggerapi/swagger-ui>
- <https://hub.docker.com/r/mrin9/rapidoc>
- <https://hub.docker.com/r/redocly/redoc>

redocly は Node.js で動作する CLI を提供している。

- <https://github.com/Redocly/openapi-cli>

## management spec file

ある程度の規模の API を書いてると人の手で書くのが辛いほど定義ファイルが大きくなってくる。

<https://github.com/Redocly/openapi-cli> を使うと単一のファイルをパスやコンポーネントごとに分割したり、逆にそれを合体させることができる。

一見、分割だけあれば良いように思える。
しかし OpenAPI と連携する各種ツールが分割されたファイルを正しく解釈できるかは分からない。

なのでリポジトリ上では分割して管理して、マージされたファイルは `.gitignore` に入れておき、必要なときだけ合体させるのが良いと思う。

ここまではスキーマファーストな前提の話。
主にハンドラーのシグネチャ、その他コメントとかアノテーションのようなもので情報を補足しつつ、ソースコードからスキーマファイルを出力するというコードファーストなアプローチもある。
例: <https://github.com/swaggo/swag>

その場合はスキーマファイルを人間が直接読み書きすることはないので特に分割したりする必要性は薄いと思われる。

## GUI editor

<https://stoplight.io/>

## code generation

### openapi-generator

<https://github.com/OpenAPITools/openapi-generator> を使うと OpenAPI の yaml or json から主に API クライアントを生成できる。
サーバのスタブも生成できる。
RESTful な API を静的型付け言語で扱う場合はサーバとクライアントでインターフェースを共有できるため便利。

<https://openapi-generator.tech/docs/generators> に対応している言語一覧が書かれている。
言語ごとに細かいオプションがあるが、その内容もここからわかる。

基本的には openapi-generator は jar で配布されているが、 OpenAPI の YAML を投げると生成されたコードの zip が返されるような Web API も存在する。
<http://api.openapi-generator.tech/index.html>

### Postman

[Postman](https://www.postman.com/) も実は OpenAPI を読み込める。
そして API を呼び出すクライアントコードのスニペットを表示できる。
openapi-generator を使うほどでも無い規模で Postman に慣れている場合は有効かもしれない。

linter

- <https://github.com/stoplightio/spectral>
- <https://github.com/Redocly/openapi-cli>

本当にドキュメント通りに API が実装されているか？
ドキュメントと実装に剥離があることは多々あるけど、それを防止するツールがある。

## validation at proxy

こういう OpenAPI があるとする。

```yaml
# openapi.yaml
openapi: "3.0.0"
info:
  title: Test
paths:
  /:
    get:
      responses:
        "200":
          content:
            application/json:
              schema:
                type: object
                properties:
                  foo:
                    type: string
```

そしてこういう実装があるとする。
ドキュメントは `foo` が `string` と主張しているが、実装は `foo` を `integer` で返しているので、これを検出したい。

```js
// index.js
const app = require("express")();

app.get("/", (_, res) => res.json({ foo: 1 }));

app.listen(8888);
```

このサーバを `npm init -y && npm i express && node index.js` で起動する。

以下のようなコマンドを叩くとバリデーション付きのプロキシサーバが建てられる。

```sh
$ prism proxy openapi.yaml http://localhost:8888 --errors
[21:11:59] › [CLI] …  awaiting  Starting Prism…
[21:11:59] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/
[21:11:59] › [CLI] ▶  start     Prism is listening on http://127.0.0.1:4010
```

ここで `curl` でプロキシサーバにリクエストを発行するとエラーが返ってくることを確認できる。

```sh
$ curl -v http://127.0.0.1:4010
*   Trying 127.0.0.1:4010...
* Connected to 127.0.0.1 (127.0.0.1) port 4010 (#0)
> GET / HTTP/1.1
> Host: 127.0.0.1:4010
> User-Agent: curl/7.77.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 500 Internal Server Error
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Headers: *
< Access-Control-Allow-Credentials: true
< Access-Control-Expose-Headers: *
< sl-violations: [{"location":["response","body","foo"],"severity":"Error","code":"type","message":"must be string"}]
< content-type: application/problem+json
< Content-Length: 338
< Date: Tue, 01 Mar 2022 12:15:30 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
<
* Connection #0 to host 127.0.0.1 left intact
{"type":"https://stoplight.io/prism/errors#VIOLATIONS","title":"Request/Response not valid","status":500,"detail":"Your request/response is not valid and the --errors flag is set, so Prism is generating this error for you.","validation":[{"location":["response","body","foo"],"severity":"Error","code":"type","message":"must be string"}]}
```

プロキシサーバを建てるのが面倒な場合はフレームワークに依存したバリデーションライブラリもいくつかあるのでそれらを使うという選択肢もある。

- <https://github.com/cdimascio/express-openapi-validator>
- <https://github.com/willnet/committee-rails>

## other tools

OpenAPI と連携可能な色んなツールがまとまってるサイト

<https://openapi.tools/>

## schema driven development

スキーマ駆動開発をしたいだけなら OpenAPI 以外にも選択肢はあると思う。

- GraphQL
- gRPC
- Protobuf
- JSONSchema
- その他、言語依存の仕組みなど…

REST という前提であれば OpenAPI は無難な選択肢だと思う。
