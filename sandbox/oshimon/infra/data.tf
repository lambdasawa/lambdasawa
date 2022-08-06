data "aws_caller_identity" "current" {}

data "archive_file" "application" {
  type        = "zip"
  source_file = "${path.module}/../bin/app"
  output_path = "${path.module}/dist.zip"
}
