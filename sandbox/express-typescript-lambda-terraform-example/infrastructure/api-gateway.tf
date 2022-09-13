module "api_gateway_api" {
  source = "./modules/api-gateway"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  name                = "api"
  function_name       = module.lambda_api.function_name
  function_invoke_arn = module.lambda_api.function_invoke_arn
}

module "api_gateway_webhook" {
  source = "./modules/api-gateway"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  name                = "webhook"
  function_name       = module.lambda_webhook.function_name
  function_invoke_arn = module.lambda_webhook.function_invoke_arn
}
