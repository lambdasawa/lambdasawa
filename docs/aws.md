# AWS

## reference

- [ドキュメント](https://docs.aws.amazon.com/ja_jp/)
- <https://github.com/aws-samples>
- [AWS ざっくり料金計算](https://aws-rough.cc/)
- [IAM Policy](https://docs.aws.amazon.com/ja_jp/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)

## IaC

### CloudFormation

- [リソースのリファレンス](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
- [組み込み関数のリファレンス](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)

### [Terraform](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started)

- [リファレンス](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### [AWS CDK](https://docs.aws.amazon.com/cdk/v2/guide/hello_world.html)

- [ガイド](https://docs.aws.amazon.com/cdk/v2/guide/home.html)
- [リファレンス](https://docs.aws.amazon.com/cdk/api/v1/docs/aws-construct-library.html)
- [examples](https://github.com/aws-samples/aws-cdk-examples/tree/master/typescript)

### [Serverless Framework](https://www.serverless.com/framework/docs/getting-started)

- [リファレンス](https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml)
- [examples](https://www.serverless.com/examples/)

## CLI

### aws-cli

- [ref](https://docs.aws.amazon.com/cli/latest/reference)

### aws-vault

- [github](https://github.com/99designs/aws-vault)
- [usage](https://github.com/99designs/aws-vault/blob/master/USAGE.md)
- [blog](https://blog.microcms.io/aws-vault-introduction)

### starship

- [github](https://starship.rs/ja-JP/config/#aws)
- プロンプトに現在アクティブな AWS のプロファイル名を出せる。
- 間違ったプロファイルで作業を防止するのに役立つ。

### awscurl

- [github](https://github.com/okigan/awscurl)
- SigV4 の署名付きで直接 API を叩きたいときに使える。
- 例えば [OpenSearch](https://opensearch.org/docs/latest/opensearch/rest-api/index/) の `_search` を直接叩いてデバッグしたいときなど…。

```sh
awscurl --service es --profile lambdasawa --region ap-northeast-1 "https://opensearch.example.com/_cat"
```

### former2

- [github](https://github.com/iann0036/former2)
- 既存のAWSリソースを読み込んで CFn,Terraform,AWS CDKのコードを生成してくれるツール。

### iamlive

- [github](https://github.com/iann0036/iamlive)
- ローカルマシンのAPI呼び出しを監視してIAMポリシーを生成してくれるツール。

## browser extension

- [AWS Extend Switch Roles](https://addons.mozilla.org/ja/firefox/addon/aws-extend-switch-roles3/)

## other

- <https://github.com/donnemartin/awesome-aws>
- [amplify-function-hotswap-plugin](https://github.com/lambdasawa/amplify-function-hotswap-plugin)
  - CDK の `--watch` のように Amplify の `functions` を シームレスに更新するコマンド。
- [lambda-versions.com](http://lambda-versions.com/)
  - Lambda ランタイムのパッチバージョンを確認できるサイト。
  - `asdf` とかでパッチバージョンを決めるときに使っている。
- [convert-datetime-to-cloudwatch-cron-expression-git-master.lambdasawa.vercel.app](https://convert-datetime-to-cloudwatch-cron-expression-git-master.lambdasawa.vercel.app/)
  - CloudWatch Events (EventBridge) で使える `cron` 式の生成をするサイト。
