resource "aws_dynamodb_table" "main" {
  name      = "oshimon"
  hash_key  = "userId"
  range_key = "timestamp"

  attribute {
    name = "userId"
    type = "N"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  ttl {
    attribute_name = "timestamp"
    enabled        = true
  }

  billing_mode = "PAY_PER_REQUEST"

  tags = local.tags
}
