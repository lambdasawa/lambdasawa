resource "aws_cognito_user_pool" "pool" {
  name = "lamb-sbx-terraform-cognito-as-openid-idp"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = aws_cognito_user_pool.pool.id

  generate_secret = true

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  callback_urls = [
    "https://yoursite.example.com/auth/oidc/callback"
  ]

  allowed_oauth_flows = ["code"]

  read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]
  write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]

  access_token_validity = 60
  id_token_validity     = 60

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

output "client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "client_secret" {
  value     = aws_cognito_user_pool_client.client.client_secret
  sensitive = true
}

output "discovery_document_url" {
  value = format(
    "https://cognito-idp.%s.amazonaws.com/%s/.well-known/openid-configuration",
    data.aws_region.current.name,
    aws_cognito_user_pool.pool.id,
  )
}
