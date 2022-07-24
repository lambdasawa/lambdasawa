data "archive_file" "application" {
  type        = "zip"
  source_file = "${path.module}/../application/bin/app"
  output_path = "${path.module}/dist.zip"
}

resource "aws_iam_role" "iam_for_lambda_main" {
  name = "sandbox-terraform-go-serverless-main"

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

resource "aws_lambda_function" "main" {
  function_name = "sandbox-terraform-go-serverless-main"

  filename = data.archive_file.application.output_path
  runtime  = "go1.x"
  handler  = "./app"

  role = aws_iam_role.iam_for_lambda_main.arn
}
