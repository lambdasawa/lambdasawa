output "apigatewayv1_endpoint_main" {
  description = "API Endpoint"
  value       = aws_api_gateway_rest_api.main.id
}

output "apigatewayv2_endpoint_main" {
  description = "API Endpoint"
  value       = aws_apigatewayv2_api.main.api_endpoint
}
