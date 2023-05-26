resource "null_resource" "lambda_source" {
  triggers = {
    hash = base64sha256(
      join(
        ",",
        [for path in fileset(path.cwd, "*.go") : filebase64sha256(path)],
      ),
    )
  }

  provisioner "local-exec" {
    command = <<EOT
      rm -rf dist/
      mkdir -p dist/
      env GOOS=linux GOARCH=amd64 go build -o dist/bootstrap
      zip -rj dist/lambda.zip dist/bootstrap
    EOT
  }
}

data "archive_file" "backend" {
  type        = "zip"
  source_file = "${path.module}/dist/bootstrap"
  output_path = "${path.module}/dist/lambda.zip"

  depends_on = [null_resource.lambda_source]
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

  depends_on = [aws_cloudwatch_log_group.lambda_main]
}
