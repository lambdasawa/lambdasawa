output "apigatewayv1_endpoint_main" {
  description = "API Endpoint"
  value = format(
    "https://%s.execute-api.%s.amazonaws.com/%s",
    aws_api_gateway_rest_api.main.id,
    local.region,
    reverse(split("/", aws_api_gateway_stage.main.arn))[0]
  )
}

output "apigatewayv2_endpoint_main" {
  description = "API Endpoint"
  value       = aws_apigatewayv2_api.main.api_endpoint
}
