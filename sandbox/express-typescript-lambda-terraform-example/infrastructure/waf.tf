module "global_waf" {
  providers = {
    aws = aws.us_east_1
  }

  source = "./modules/global-waf"

  project = local.project
  stage   = local.stage
  tags    = local.tags

  ip_whitelist = var.ip_whitelist
}
