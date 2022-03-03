# Main infrastructure layout.
# Create modules for your projects and call them here.

# Security demonstrator API.
module "security_demo" {
  source = "./modules/security_demo"
}
module "endpoint_01" {
  source            = "./modules/security_demo_endpoint"
  api_root_id       = module.security_demo.api_root_id
  api_id            = module.security_demo.api_id
  api_validator     = module.security_demo.api_validator
  api_execution_arn = module.security_demo.api_execution_arn
  api_url           = module.security_demo.api_url
}
output "endpoint_01_url" {
  value     = module.endpoint_01.api_endpoint
  sensitive = false
}

# Tennis.
module "tennis" {
  source = "./modules/tennis"
}
