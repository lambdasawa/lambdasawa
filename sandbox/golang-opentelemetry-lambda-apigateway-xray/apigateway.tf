resource "aws_api_gateway_rest_api" "main" {
  name = local.name
}

resource "aws_api_gateway_resource" "main" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

resource "aws_api_gateway_method" "root" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_rest_api.main.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_rest_api.main.root_resource_id
  http_method             = aws_api_gateway_method.root.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main.invoke_arn
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.main.id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main.invoke_arn
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = data.archive_file.backend.output_base64sha256
  }

  depends_on = [
    aws_api_gateway_rest_api.main,
    aws_api_gateway_resource.main,
    aws_api_gateway_method.root,
    aws_api_gateway_method.main,
    aws_api_gateway_integration.root,
    aws_api_gateway_integration.main,
    aws_api_gateway_deployment.main,
    aws_lambda_permission.apigw_lambda,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "main"

  xray_tracing_enabled = true
}

resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.main.function_name

  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.main.id}/*/*/*"
}

output "lambda_endpoint" {
  value = aws_api_gateway_stage.main.invoke_url
}
