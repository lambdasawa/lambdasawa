locals {
  dynamodb_table_name_user = "${local.project}-user-${var.stage}"
}

resource "aws_dynamodb_table" "user" {
  name = local.dynamodb_table_name_user

  hash_key = "id"
  attribute {
    name = "id"
    type = "N"
  }

  read_capacity  = 1
  write_capacity = 1

  tags = local.tags
}
