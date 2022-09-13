terraform {
  required_version = ">= 1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

resource "aws_wafv2_web_acl" "allow_all" {
  name        = "${var.project}-allow-all-${var.stage}"
  description = "${var.project}-allow-all-${var.stage}"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.project}-allow-all-${var.stage}"

    sampled_requests_enabled = false
  }

  tags = var.tags
}

resource "aws_wafv2_web_acl" "ip_restriction" {
  name        = "${var.project}-ip-restriction-${var.stage}"
  description = "${var.project}-ip-restriction-${var.stage}"
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "allow-ip-whitelist"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.my_office.arn
      }
    }


    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.project}-ip-restriction-${var.stage}"

      sampled_requests_enabled = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.project}-ip-restriction-${var.stage}"

    sampled_requests_enabled = false
  }

  tags = var.tags
}

resource "aws_wafv2_ip_set" "my_office" {
  name               = "${var.project}-my-office-${var.stage}"
  description        = "${var.project}-my-office-${var.stage}"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = toset(split(",", var.ip_whitelist))

  tags = var.tags
}
