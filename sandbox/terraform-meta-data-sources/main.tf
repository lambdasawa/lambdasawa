
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.26.0"
    }
  }

  backend "s3" {}
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ssm_parameter" "main" {
  name = "/github.com/lambdasawa/lambdasawa/sandbox/terraform-meta-data-sources"
}

data "aws_secretsmanager_secret_version" "main" {
  secret_id = "lamb-sbx-terraform-meta-data-sources"
}

resource "aws_s3_bucket" "main" {
  bucket = "lamb-terraform-metadata-sources"
}

resource "aws_s3_bucket" "us_east_1" {
  provider = aws.us_east_1

  bucket = "lamb-terraform-metadata-sources-us-east-1"
}

output "values" {
  value = {
    account_id : data.aws_caller_identity.current.account_id,
    arn : data.aws_caller_identity.current.arn,
    region : data.aws_region.current.name,
  }
}
