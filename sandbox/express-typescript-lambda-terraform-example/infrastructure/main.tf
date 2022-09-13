terraform {
  required_version = ">= 1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "main"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

data "aws_caller_identity" "self" {}

locals {
  project = var.project
  stage   = var.stage

  repository_root = var.repository_root

  tags = {
    Project = var.project
    Stage   = var.stage
  }
}
