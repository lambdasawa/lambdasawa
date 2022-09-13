resource "aws_ssm_parameter" "webhook_signature_secret" {
  name  = "/${local.project}/${local.stage}/webhook-signature-secret"
  type  = "SecureString"
  value = var.webhook_signature_secret

  tags = local.tags
}

resource "aws_ssm_parameter" "webhook_signature_secret2" {
  name  = "/${local.project}/${local.stage}/webhook-signature-secret2"
  type  = "SecureString"
  value = var.webhook_signature_secret

  tags = local.tags
}
