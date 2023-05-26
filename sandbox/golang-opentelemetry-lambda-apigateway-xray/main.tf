terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  name = "golang-opentelemetry-lambda-apigateway-xray"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
