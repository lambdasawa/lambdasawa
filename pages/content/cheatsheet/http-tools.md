---
title: HTTP tools
---

## httpie

- [doc](https://httpie.io/docs/cli)
- [example](https://httpie.io/docs/cli/examples)
- リッチなcurl

```sh
# こんな感じで JSON を POST できる
$ http -v "https://httpbin.org/anything" "x-my-header: xxxx" foo[bar]=fizz

# 同等の処理を curl でやるとこんな感じ
$ curl -v "https://httpbin.org/anything" -X POST -H "x-my-header: xxxx" --data '{"foo": {"bar": "fizz"}}'
```

レスポンスは自動的にインデントとシンタックスハイライトがされる。

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
- [ngrok \| λ沢.dev](https://www.lambdasawa.dev/ngrok)

## Caddy

- ACME を実装した Web サーバ (certbot + nginx 的なイメージ)
- <https://caddyserver.com/docs/getting-started>

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

## [CyberChef](https://gchq.github.io/CyberChef/)

雑多な変換処理を行えるウェブサイト。

- base64
- URL エンコード/デコード
- gunzip
- zlib deflate
- JWT デコード
- などなど

使用例:

- [Unix timestamp to RFC3339(JST)](https://gchq.github.io/CyberChef/#recipe=From_UNIX_Timestamp('Milliseconds%20(ms)')Translate_DateTime_Format('Standard%20date%20and%20time','ddd%20DD%20MMM%20YYYY%20HH:mm:ss','UTC','YYYY-MM-DDTHH:mm:ss','Asia/Tokyo')&input=MTY1NjI4NzU2NDE5Ng)
- [JWT decode](https://gchq.github.io/CyberChef/#recipe=JWT_Decode()&input=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnpkV0lpT2lJeE1qTTBOVFkzT0Rrd0lpd2libUZ0WlNJNklrcHZhRzRnUkc5bElpd2lhV0YwSWpveE5URTJNak01TURJeWZRLlNmbEt4d1JKU01lS0tGMlFUNGZ3cE1lSmYzNlBPazZ5SlZfYWRRc3N3NWM)
