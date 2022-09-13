locals {
  cloudfront_origin_id_s3 = "S3Origin"
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "${local.project}-main-${var.stage}"
}

resource "aws_cloudfront_distribution" "main" {
  enabled = true

  comment = "${local.project}-main-${var.stage}"

  origin {
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = local.cloudfront_origin_id_s3
  }


  default_cache_behavior {
    target_origin_id = local.cloudfront_origin_id_s3

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = var.stage == "production" ? module.global_waf.allow_all_arn : module.global_waf.ip_restriction_arn

  wait_for_deployment = false

  tags = local.tags
}
