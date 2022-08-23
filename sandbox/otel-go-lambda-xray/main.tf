terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  name = "otel-go-lambda-xray"
  tags = {}
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "archive_file" "backend" {
  type        = "zip"
  source_file = "${path.module}/dist/bootstrap"
  output_path = "${path.module}/dist/lambda.zip"
}

resource "aws_lambda_function" "main" {
  function_name = "${local.name}-main"

  role = aws_iam_role.lambda_main.arn

  runtime          = "provided.al2"
  handler          = "bootstrap"
  filename         = data.archive_file.backend.output_path
  source_code_hash = data.archive_file.backend.output_base64sha256

  layers = [
    "arn:aws:lambda:${data.aws_region.current.name}:901920570463:layer:aws-otel-collector-amd64-ver-0-56-0:1"
  ]

  tracing_config {
    mode = "Active"
  }

  timeout = 10

  depends_on = [
    aws_cloudwatch_log_group.lambda_main,
    aws_iam_role_policy_attachment.main,
  ]

  tags = local.tags
}

resource "aws_cloudwatch_log_group" "lambda_main" {
  name              = "/aws/lambda/${local.name}-main"
  retention_in_days = 14
}

resource "aws_iam_role" "lambda_main" {
  name = "${local.name}-lambda-main"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_main" {
  name        = "${local.name}-lambda-main"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          // https://aws-otel.github.io/docs/setup/permissions
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.lambda_main.name
  policy_arn = aws_iam_policy.lambda_main.arn
}

resource "aws_api_gateway_rest_api" "main" {
  name = local.name

  tags = local.tags
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


output "log_group" {
  value = aws_cloudwatch_log_group.lambda_main.name
}
