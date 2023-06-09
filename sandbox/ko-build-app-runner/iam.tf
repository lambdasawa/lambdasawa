resource "aws_iam_role" "apprunner_access_role" {
  name = "apprunner-access-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : [
            "build.apprunner.amazonaws.com",
          ]
        },
        "Effect" : "Allow",
        "Sid" : "main"
      }
    ]
  })
}

resource "aws_iam_policy" "apprunner_access_role" {
  name = "apprunner-access-role"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          # https://docs.aws.amazon.com/ja_jp/apprunner/latest/dg/security_iam_service-with-iam.html
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect : "Allow",
        Resource : "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "apprunner_access_role" {
  role       = aws_iam_role.apprunner_access_role.name
  policy_arn = aws_iam_policy.apprunner_access_role.arn
}

resource "aws_iam_role" "apprunner_instance_role" {
  name = "apprunner-instance-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : [
            "tasks.apprunner.amazonaws.com"
          ]
        },
        "Effect" : "Allow",
        "Sid" : "main"
      }
    ]
  })
}

resource "aws_iam_policy" "apprunner_instance_role" {
  name = "apprunner-instance-role"

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
          // https://aws-otel.github.io/docs/setup/permissions
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
        ],
        Effect : "Allow",
        Resource : "*"
      },
      {
        Action : [
          "s3:ListGetObject",
        ],
        Effect : "Allow",
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "apprunner_instance_role" {
  role       = aws_iam_role.apprunner_instance_role.name
  policy_arn = aws_iam_policy.apprunner_instance_role.arn
}
