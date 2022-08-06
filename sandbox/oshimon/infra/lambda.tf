resource "aws_lambda_function" "main" {
  function_name = "oshimon"

  filename         = data.archive_file.application.output_path
  source_code_hash = data.archive_file.application.output_sha
  runtime          = "go1.x"
  handler          = "./app"

  environment {
    variables = jsondecode(
      data.aws_secretsmanager_secret_version.main.secret_string
    )
  }

  timeout = 10

  role = aws_iam_role.iam_for_lambda_main.arn

  tags = local.tags

  depends_on = [
    aws_iam_role_policy_attachment.lambda_main,
    aws_cloudwatch_log_group.lambda_main,
  ]
}

resource "aws_iam_role" "iam_for_lambda_main" {
  name = "oshimon"

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

resource "aws_iam_policy" "iam_for_lambda_main" {
  name = "oshimon"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect : "Allow",
        Resource : "*"
      },
      {
        Action : [
          "dynamodb:PutItem",
          "dynamodb:Query",
        ],
        Effect : "Allow",
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_main" {
  role       = aws_iam_role.iam_for_lambda_main.id
  policy_arn = aws_iam_policy.iam_for_lambda_main.arn
}

resource "aws_cloudwatch_log_group" "lambda_main" {
  name = "/aws/lambda/oshimon"
}
