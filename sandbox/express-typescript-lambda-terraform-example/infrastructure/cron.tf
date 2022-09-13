resource "aws_cloudwatch_event_rule" "cron" {
  name = "${var.project}-${var.stage}"

  schedule_expression = "cron(*/5 * * * ? *)"

  tags = local.tags
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.cron.name
  target_id = "InvokeFunction"
  arn       = module.lambda_schedule.function_arn
}

resource "aws_lambda_permission" "cron" {
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = module.lambda_schedule.function_name
  source_arn    = aws_cloudwatch_event_rule.cron.arn
}
