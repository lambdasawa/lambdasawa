locals {
  lambda_environment_variables = {
    OPENSEARCH_URL : length(aws_opensearch_domain.example) > 1 ? "https://${aws_opensearch_domain.example[0].endpoint}" : ""
    USER_TABLE_NAME : local.dynamodb_table_name_user
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${var.repository_root}/application/dist"
  output_path = "${var.repository_root}/application/dist.zip"
}

module "lambda_api" {
  source = "./modules/lambda"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  name                         = "api"
  lambda_filename              = data.archive_file.lambda.output_path
  lambda_source_code_hash      = data.archive_file.lambda.output_base64sha256
  lambda_environment_variables = local.lambda_environment_variables
  alarm_sns_topic_arn          = var.alarm_sns_topic_arn
}

module "lambda_webhook" {
  source = "./modules/lambda"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  name                         = "webhook"
  lambda_filename              = data.archive_file.lambda.output_path
  lambda_source_code_hash      = data.archive_file.lambda.output_base64sha256
  lambda_environment_variables = local.lambda_environment_variables
  alarm_sns_topic_arn          = var.alarm_sns_topic_arn
}

module "lambda_schedule" {
  source = "./modules/lambda"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  name                         = "schedule"
  lambda_filename              = data.archive_file.lambda.output_path
  lambda_source_code_hash      = data.archive_file.lambda.output_base64sha256
  lambda_environment_variables = local.lambda_environment_variables
  alarm_sns_topic_arn          = var.alarm_sns_topic_arn
}
