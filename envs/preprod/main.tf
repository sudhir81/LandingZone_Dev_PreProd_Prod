module "core" {
  source = "../../modules/core"

  environment     = "preprod"
  subscription_id = "/subscriptions/${var.subscription_id_raw}"
  tenant_id       = var.tenant_id
  location        = var.location
  tags            = var.tags

  rg_names = var.rg_names

  law_name           = var.law_name
  law_retention_days = var.law_retention_days

  central_storage_account_name = var.central_storage_account_name

  hub_vnet_name     = var.hub_vnet_name
  hub_address_space = var.hub_address_space
  hub_subnets       = var.hub_subnets

  enable_bastion        = var.enable_bastion
  bastion_subnet_prefix = var.bastion_subnet_prefix

  spoke_vnet_name     = var.spoke_vnet_name
  spoke_address_space = var.spoke_address_space
  spoke_subnets       = var.spoke_subnets

  key_vault_name    = var.key_vault_name
  kv_rbac_enabled   = var.kv_rbac_enabled

  reader_object_ids      = var.reader_object_ids
  contributor_object_ids = var.contributor_object_ids

  allowed_locations = var.allowed_locations
  enforce_policies  = var.enforce_policies
}

output "key_vault_uri" {
  value = module.core.key_vault_uri
}

output "resource_groups" {
  value = module.core.resource_groups
}
