resource "aws_dynamodb_table" "main" {
  name      = "sandbox-terraform-go-serverless-main"
  hash_key  = "hashKey"
  range_key = "rangeKey"

  attribute {
    name = "hashKey"
    type = "S"
  }

  attribute {
    name = "rangeKey"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
}
