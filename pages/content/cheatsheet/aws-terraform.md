---
title: aws-terraform
---

## init

```sh
curl -o main.tf https://www.lambdasawa.dev/data/aws-terraform-template.tf
read TF_BACKEND_BUCKET_NAME
aws s3 mb "s3://$TF_BACKEND_BUCKET_NAME" &&\
  aws s3api put-bucket-versioning \
    --bucket "$TF_BACKEND_BUCKET_NAME" \
    --versioning-configuration Status=Enabled &&\
  aws s3api put-public-access-block \
    --bucket "$TF_BACKEND_BUCKET_NAME" \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
terraform init \
  -backend-config="bucket=$TF_BACKEND_BUCKET_NAME" \
  -backend-config="key=terraform.tfstate"
terraform plan
```

## reference

- [AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
  - [backend](https://www.terraform.io/language/settings/backends/s3)
  - [IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
  - [Lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
  - [S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
  - [DynamoDB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)
  - [OpenSearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain)
  - [EFS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)
  - [CloudFront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)
  - [WAF](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl)
  - [API Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api)
  - [Caller info (account id, user id, ...)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
  - [Region info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)
- [null_resource provider](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- [Functions](https://www.terraform.io/language/functions)
- meta arguments
  - [providers](https://www.terraform.io/language/meta-arguments/module-providers)
  - [depends_on](https://www.terraform.io/language/meta-arguments/depends_on)
  - [count](https://www.terraform.io/language/meta-arguments/count)
  - [for_each](https://www.terraform.io/language/meta-arguments/for_each)
  - [lifecycle](https://www.terraform.io/language/meta-arguments/lifecycle)
- [local-exec provisioner](https://www.terraform.io/language/resources/provisioners/local-exec)

## tutorial

- <https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started>
- <https://github.com/bregman-arie/devops-exercises/blob/master/exercises/terraform/README.md>

## best practice

- [Terraform を使用するためのベスト プラクティス  \|  Google Cloud](https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja)
- [ベストな Terraform ディレクトリ構成を考察してみた](https://speakerdeck.com/harukasakihara/besutona-terraform-deirekutorigou-cheng-wokao-cha-sitemita)
- [12 Terraform Best Practices to Improve your TF workflow](https://spacelift.io/blog/terraform-best-practices)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- <https://github.com/shuaibiyy/awesome-terraform>
- <https://github.com/ozbillwang/terraform-best-practices>
- <https://github.com/nsriram/lambda-the-terraform-way>
- <https://spacelift.io/blog/terraform-aws-lambda>

## lint

- <https://github.com/terraform-linters/tflint>

## GitHub Actions

- [Terraform開発時のDeveloper Experienceを爆上げする](https://zenn.dev/honmarkhunt/articles/2f03cba1ffe966)
- <https://github.com/marketplace/actions/hashicorp-setup-terraform>
- <https://github.com/runatlantis/atlantis>

## import

- <https://github.com/GoogleCloudPlatform/terraformer/blob/master/docs/aws.md>
- <https://github.com/cycloidio/terracognita>
- [IaC化されていないリソースをdriftctlで検知する](https://zenn.dev/gosarami/articles/dd938001eac988e44d11)

## security

- <https://github.com/aquasecurity/tfsec>
- <https://github.com/tenable/terrascan>
- [Terraform で秘密情報を扱う](https://engineering.mobalab.net/2021/03/25/handling-secrets-with-terraform/)
- [セキュアなTerraformの使い方 ～ 機密情報をコードに含めず環境構築するにはどうしたらいいの？](https://speakerdeck.com/harukasakihara/sekiyuanaterraformfalseshi-ifang-ji-mi-qing-bao-wokodonihan-mezuhuan-jing-gou-zhu-surunihadousitaraiifalse)

## test

- <https://github.com/gruntwork-io/terratest>
- [Top 3 Terraform Testing Strategies for Ultra-Reliable Infrastructure-as-Code](https://www.contino.io/insights/top-3-terraform-testing-strategies-for-ultra-reliable-infrastructure-as-code)
