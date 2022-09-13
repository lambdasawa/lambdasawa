output "api_invoke_url" {
  value = module.api_gateway_api.invoke_url
}

output "webhook_invoke_url" {
  value = module.api_gateway_webhook.invoke_url
}
