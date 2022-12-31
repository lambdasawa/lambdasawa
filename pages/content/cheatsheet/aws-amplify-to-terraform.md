---
title: Apmlify to Terraform
---

## DynamoDB

GraphQL で作成した `@model` を Terraform に移行する。

- amplify の中身は CloudFormation
- `@model` を削除するとテーブルが消える
- amplify の管理からは外したいが、テーブル自体は残って欲しい
- 一般に CloudFormation で管理している AWS リソースを CloudFormation の管理外に置くには以下の手順が必要になる
  - DeletionPolicy を Retain にする
  - スタックからそのリソースを削除する (またはスタックごと削除)
  - [参考](https://aws.amazon.com/jp/premiumsupport/knowledge-center/delete-cf-stack-retain-resources/)
- amplify で作られたテーブルの DeletionPolicy は Delete になっている
- つまり `@model` ディレクティブを外すとテーブルが消えてしまう
- amplify の仕組みでは直接 CloudFormation のテンプレートをいじって DynamoDB の DeletionPolicy を変更することはできない
- graphql-transformer を使うとテンプレートをいじれる
- それを実装したものが公開されている
  - <https://react-freelancer.ch/blog/amplify-retain-dynamodb-tables>
  - スターは少ないが実装は薄い
  - `@retain` ディレクティブを付けることで `DeletionPolicy` を `Retain` にできる
- ここまでの情報を使って、以下のように作業すると amplify で作られた DynamoDB テーブルを Terraform に移行することができるといえる
  - `amplify-retain-dynamodb-tables` を導入する
  - `@model` がついてるところ全ての `@retain` を付ける
  - `amplify push` をする
  - CloudFormation をコンソールで確認して `DeletionPolicy` が `Retain` になったことを確認する
  - `@retain` がついてるところ全ての `@model` を削除する
  - `amplify push` をする
  - CloudFormation をコンソールで確認して `AWS::DynamoDB::Table` が無いことを確認する
  - DynamoDB をコンソールで書くんしてテーブルが残っていることを確認する
  - あとは普通に `terraform import` するだけ
