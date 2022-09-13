output "allow_all_arn" {
  value = aws_wafv2_web_acl.allow_all.arn
}

output "ip_restriction_arn" {
  value = aws_wafv2_web_acl.ip_restriction.arn
}
