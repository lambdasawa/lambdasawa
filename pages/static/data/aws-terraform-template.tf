terraform {
  # https://github.com/hashicorp/terraform/releases
  required_version = ">= 1.2.8"

  required_providers {
    aws = {
      # https://github.com/hashicorp/terraform-provider-aws/releases
      source  = "hashicorp/aws"
      version = "~> 4.29"
    }
  }

  backend "s3" {}
}

locals {
  common_tags = {
    Project = "foo"
    Environment = "development"
  }
}

provider "aws" {
  default_tags {
    tags = local.common_tags
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"

  default_tags {
    tags = local.common_tags
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
