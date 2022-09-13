variable "project" {}
variable "stage" {}
variable "tags" {}

variable "name" {}
variable "lambda_filename" {}
variable "lambda_source_code_hash" {}
variable "lambda_environment_variables" { type = map(any) }
variable "alarm_sns_topic_arn" {}
