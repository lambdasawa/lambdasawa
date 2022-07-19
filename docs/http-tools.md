# HTTP tools

## httpie

- [doc](https://httpie.io/docs/cli)
- [example](https://httpie.io/docs/cli/examples)
- リッチなcurl

## curlie

- [github](https://github.com/rs/curlie)
- リッチなcurl

## Insomnia

- <https://insomnia.rest>
- GUIのHTTPクライアント
- GraphQL にも対応してる

## Postman

- <https://www.postman.com>
- GUIのHTTPクライアント

## Hoppscotch

- <https://hoppscotch.io/ja/>
- ブラウザで動作するGUIのHTTPクライアント

## httpbin

- <https://httpbin.org/>
- 色んな種類のレスポンスを返すWebサーバ。HTTPクライアントの検証として使える。

## ngrok

- tunneling tool
- [awesome-tunneling](https://github.com/anderspitman/awesome-tunneling)
- [doc](https://ngrok.com/docs)
- [ngrok | λ沢.dev](https://www.lambdasawa.dev/ngrok)

## webhook.site

- <https://webhook.site/>
- Webhookの受け側を生成するサイト
- Webhookの受け側を作るときにリクエストを観察するために使う

## mitmproxy

- <https://mitmproxy.org/>
- ローカルで使うプロキシ
- ブラウザを介さないWebサーバを作るときにreq/resを観察するために使う

```sh
python -m http.server 8000
mitmweb --mode reverse:http://localhost:8000 --listen-port 8001 --web-port 8002
curl localhost:8001
open http://locahost:8002
```

## BurpSuite

- <https://portswigger.net/burp>
- proxy
