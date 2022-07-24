resource "aws_apigatewayv2_api" "main" {
  name          = "sandbox-terraform-go-serverless-main"
  protocol_type = "HTTP"
  target        = aws_lambda_function.main.arn

  tags = local.tags
}

resource "aws_lambda_permission" "apigateway_main" {
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.arn
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
