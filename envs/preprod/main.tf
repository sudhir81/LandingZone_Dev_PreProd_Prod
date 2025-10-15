module "core" {
  source   = "../../modules/core"
  env      = var.env
  location = var.location
  tags     = var.tags
}

output "rg_name" {
  value = module.core.rg_name
}
