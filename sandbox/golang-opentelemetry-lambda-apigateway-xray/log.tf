resource "aws_cloudwatch_log_group" "lambda_main" {
  name              = "/aws/lambda/${local.name}-main"
  retention_in_days = 14
}

output "log_group" {
  value = aws_cloudwatch_log_group.lambda_main.name
}
