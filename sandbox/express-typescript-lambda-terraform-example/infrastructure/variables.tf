variable "project" {
  type = string
}

variable "stage" {
  type = string
}

variable "repository_root" {
  type = string
}

variable "ip_whitelist" {}

variable "alarm_sns_topic_arn" {}

variable "webhook_signature_secret" {}
