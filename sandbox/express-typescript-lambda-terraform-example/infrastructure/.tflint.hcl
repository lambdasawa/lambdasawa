# https://github.com/terraform-linters/tflint
# https://github.com/terraform-linters/tflint-ruleset-aws
plugin "aws" {
  enabled = true
  version = "0.13.4"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
