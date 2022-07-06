# [ドキュメント](https://docs.aws.amazon.com/ja_jp/)

- <https://github.com/aws-samples>
- [AWS ざっくり料金計算](https://aws-rough.cc/)

## IaC


### AWS CDK

[プロジェクト初期化](https://docs.aws.amazon.com/cdk/latest/guide/hello_world.html#hello_world_tutorial_create_app)

```sh
read project_name
mkdir -p $project_name
cd $project_name
npx cdk init app --language typescript
```

## CLI

### [aws-cli](https://docs.aws.amazon.com/cli/latest/reference/)

### [aws-vault](https://github.com/99designs/aws-vault)

<https://blog.microcms.io/aws-vault-introduction/>

### [starship](https://starship.rs/ja-JP/config/#aws)

プロンプトに現在アクティブな AWS のプロファイル名を出せる。
間違ったプロファイルで作業を防止するのに役立つ。

### [awscurl](https://github.com/okigan/awscurl)

SigV4 の署名付きで直接 API を叩きたいときに使える。
例えば OpenSearch の `_search` を直接叩いてデバッグしたいときなど…。

### [former2](https://github.com/iann0036/former2)

既存のAWSリソースを読み込んで CFn,Terraform,AWS CDKのコードを生成してくれるツール。

### [iamlive](https://github.com/iann0036/iamlive)

ローカルマシンのAPI呼び出しを監視してIAMポリシーを生成してくれるツール。

## ブラウザ拡張

- [AWS Extend Switch Roles](https://addons.mozilla.org/ja/firefox/addon/aws-extend-switch-roles3/)

foo
