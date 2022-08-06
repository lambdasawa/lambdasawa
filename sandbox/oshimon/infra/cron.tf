resource "aws_cloudwatch_event_rule" "every_minutes" {
  name                = "oshimon-every-minutes"
  schedule_expression = "cron(* * * * ? *)"

  tags = local.tags
}

resource "aws_cloudwatch_event_target" "every_minutes_lambda_main" {
  rule = aws_cloudwatch_event_rule.every_minutes.name
  arn  = aws_lambda_function.main.arn
}

resource "aws_lambda_permission" "cron_main" {
  principal     = "events.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  source_arn    = aws_cloudwatch_event_rule.every_minutes.arn
}
