# ngrok

[doc](https://ngrok.com/docs)

## localhost:8888 をトンネリング

```sh
ngrok http 8888
```

## カレントディレクトリをトンネリング

```sh
ngrok http file://$PWD
```

## localhost:8888 を <https://xxxx.jp.ngrok.io/> で公開

```sh
ngrok http --subdomain=xxxx 8888
```

## localhost:8888 を Basic 認証付きでトンネリング

```sh
ngrok http --basic-auth foo:hogehoge 8888
```

## localhost:8888 を Google の OAuth 認証付きでトンネリング

```sh
ngrok http --oauth=google --oauth-allow-email=foo@gmail.com,bar@gmail.com 8888
```

- `google` 以外に `facebook`, `github`, `microsoft` に対応
- `--oauth-allow-email` はオプショナル
  - この設定の場合、 `foo@gmail.com`, `bar@gmail.com` のアカウントだけが `localhost:8888` にアクセスできる
