resource "aws_wafv2_web_acl" "main" {
  provider = aws.us_east_1

  name = "sandbox-terraform-go-serverless"

  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "JP"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "sandbox-terraform-go-serverless-rule-1"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "sandbox-terraform-go-serverless"
    sampled_requests_enabled   = false
  }

  tags = local.tags
}
