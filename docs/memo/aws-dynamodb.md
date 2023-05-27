---
title: DynamoDB
---

- [Best practices for designing and architecting with DynamoDB](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/best-practices.html)
- [Amazon DynamoDB Advanced Design Pattern](https://www.youtube.com/watch?v=Wd5gbLQ2a1E)
- [Amazon DynamoDB Deep Dive](https://www.youtube.com/watch?v=16RYHfe89WY)

## emulator

- [LocalStack](https://hub.docker.com/r/localstack/localstack)
- [dynamodb-local](https://hub.docker.com/r/amazon/dynamodb-local)

## CLI client

### dynein

- [github](https://github.com/awslabs/dynein)

DynamoDB へのアクセスを考えた時、 awscli は網羅的であるが `expression-attribute-values` の指定が面倒だったりする。

`dynein` を使うとその辺りをシンプルに書ける。

まだ成熟してない(例えばページング処理が実装されてない)が、 基本的なユースケースでは awscli より便利。
リポジトリにコミットしてシェアするようなスクリプトでは awscli を使ったほうが良いと思うが、一時的な調査の作業などには便利。

## GUI client

## NoSQL Workbench

- [ref](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/workbench.settingup.html)
- GUIクライアント。無料。

## Dynobase

- [ref](https://dynobase.dev/)
- GUIクライアント。有料。

## dynamodb-admin

- [ref](https://www.npmjs.com/package/dynamodb-admin)
- ローカルで動く管理画面

```sh
$ env DYNAMO_ENDPOINT=http://localhost:8000 PORT=8001 dynamodb-admin
open http://localhost:8001
```
