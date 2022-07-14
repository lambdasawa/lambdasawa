# JWT

<https://openid-foundation-japan.github.io/draft-ietf-oauth-json-web-token-11.ja.html>

## decode

### browser

<https://jwt.io/>

### cli

<https://github.com/mike-engel/jwt-cli>

```sh
brew install mike-engel/jwt-cli/jwt-cli
```

```sh
$ jwt decode -j eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
{
  "header": {
    "typ": "JWT",
    "alg": "HS256"
  },
  "payload": {
    "iat": 1516239022,
    "name": "John Doe",
    "sub": "1234567890"
  }
}
```

## structure

- ヘッダー、ペイロード、シグネチャの3つがある
- ヘッダーは Base64 エンコードされた JSON
- ペイロードは Base64 エンコードされた JSON
  - 予約語的なものもあるが、基本的には何を入れても良い
  - `sub` はユーザ ID として使える
- シグネチャはヘッダーとペイロードを `.` で繋げた文字列の署名を Base64 エンコードしたもの
- JWT とはヘッダーとペイロードとシグネチャを `.` で繋げた文字列

## verification

- 署名検証
  - ヘッダーとペイロードから作ったシグネチャと、 `.` で区切った文字列の末尾が一致するか検証する
  - シグネチャの作成に必要な鍵の作成方法はサービスによる
    - Google OpenID Connect では `https://www.googleapis.com/oauth2/v3/certs` で JWK として公開されている
    - AWS Cognito では `https://cognito-idp.{region}.amazonaws.com/{userPoolId}/.well-known/jwks.json` で JWK として公開されている
- `aud`
  - 誰がこの JWT を受信するべきか
  - Google OpenID Connect や AWS Cognito ではクライアント ID と呼ばれる値が入っている
- `iss`
  - 誰がこの JWT を発行したか
  - IdP ごとに固定の値が入る
- `exp`
  - 期限
  - `現在時刻 < exp` であるべき
- `iat`
  - 発行日時
  - `現在時刻 > iat` であるべき
- その他
  - 例えば AWS Cognito は「`token_use` を検証してね」と[マニュアル](https://docs.aws.amazon.com/ja_jp/cognito/latest/developergu…ing-a-jwt.html#amazon-cognito-user-pools-using-tokens-step-3)に書いてある
