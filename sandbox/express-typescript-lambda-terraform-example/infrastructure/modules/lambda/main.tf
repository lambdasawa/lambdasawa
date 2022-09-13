locals {
  name = "${var.project}-${var.name}-${var.stage}"
}

resource "aws_lambda_function" "main" {
  function_name = local.name

  handler          = "index.${var.name}"
  filename         = var.lambda_filename
  source_code_hash = var.lambda_source_code_hash

  runtime = "nodejs14.x"

  environment {
    variables = merge(
      {
        stage = var.stage
      },
      var.lambda_environment_variables,
    )
  }

  role = aws_iam_role.main.arn

  tags = var.tags
}

resource "aws_iam_role" "main" {
  name = local.name
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

  tags = var.tags
}

resource "aws_iam_policy" "main" {
  name = local.name

  path = "/"

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
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "main" {
  role = aws_iam_role.main.name

  policy_arn = aws_iam_policy.main.arn
}

resource "aws_cloudwatch_metric_alarm" "error" {
  alarm_name = "${var.project}-${var.name}-error-${var.stage}"

  namespace   = "AWS/Lambda"
  metric_name = "Errors"
  dimensions = {
    FunctionName = local.name
  }

  statistic           = "Sum"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period             = "60"
  evaluation_periods = "1"
  threshold          = "1"

  ok_actions                = [var.alarm_sns_topic_arn]
  alarm_actions             = [var.alarm_sns_topic_arn]
  insufficient_data_actions = [var.alarm_sns_topic_arn]

  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "throttle" {
  alarm_name = "${var.project}-${var.name}-throttle-${var.stage}"

  namespace   = "AWS/Lambda"
  metric_name = "Throttles"
  dimensions = {
    FunctionName = local.name
  }

  statistic           = "Sum"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period             = "60"
  evaluation_periods = "1"
  threshold          = "1"

  ok_actions                = [var.alarm_sns_topic_arn]
  alarm_actions             = [var.alarm_sns_topic_arn]
  insufficient_data_actions = [var.alarm_sns_topic_arn]

  treat_missing_data = "notBreaching"
}
