terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "domain" {
  default = "sandbox-single"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "log_publishing" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream",
    ]

    resources = ["arn:aws:logs:*"]
  }
}

resource "aws_cloudwatch_log_resource_policy" "log_publishing" {
  policy_name     = "log-publishing"
  policy_document = data.aws_iam_policy_document.log_publishing.json
}

resource "aws_cloudwatch_log_group" "index_slow_log" {
  name = "/aws/aes/domains/${var.domain}/index-slow-logs"
}

resource "aws_elasticsearch_domain" "main" {
  domain_name           = var.domain
  elasticsearch_version = "7.10"

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": ["192.0.2.1/32"]}
      }
    }
  ]
}
POLICY

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.index_slow_log.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
}
