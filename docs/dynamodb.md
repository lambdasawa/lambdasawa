<https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide>

<https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/best-practices.html>

<https://www.youtube.com/watch?v=Wd5gbLQ2a1E>

<https://www.youtube.com/watch?v=16RYHfe89WY&t=1257s>

# エミュレータ

- [dynamodb-local](https://hub.docker.com/r/amazon/dynamodb-local)
- [LocalStack](https://hub.docker.com/r/localstack/localstack)

# GUI クライアント

## [NoSQL Workbench](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/workbench.settingup.html)

GUIクライアント。無料。

## [Dynobase](https://dynobase.dev/)

GUIクライアント。有料。

## [dynamodb-admin](https://www.npmjs.com/package/dynamodb-admin)

ローカルで動く管理画面。

```
$ env DYNAMO_ENDPOINT=http://localhost:8000 PORT=8001 dynamodb-admin
open http://localhost:8001
```
