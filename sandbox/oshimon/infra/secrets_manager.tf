# aws secretsmanager create-secret --name oshimon --secret-string '{"TEST":"TEST"}'
# aws secretsmanager put-secret-value --secret-id oshimon --secret-string "$(cat .env | jc --env | jq 'from_entries')"

data "aws_secretsmanager_secret" "main" {
  name = "oshimon"
}

data "aws_secretsmanager_secret_version" "main" {
  secret_id = "oshimon"
}
