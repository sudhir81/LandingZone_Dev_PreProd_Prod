subscription_id_raw = "1c95c3eb-55ac-4d47-bee1-e823c941e413"
tenant_id           = "<YOUR_TENANT_ID>"

location = "East US"

tags = {
  environment = "prod"
  owner       = "cloud-team"
  workload    = "landing-zone"
  cost_center = "CLOUD-001"
}

rg_names = {
  management = "rg-prod-mgmt"
  network    = "rg-prod-net"
  workload   = "rg-prod-app"
  security   = "rg-prod-sec"
}

law_name           = "log-prod-central"
law_retention_days = 30

central_storage_account_name = "prodsa001"

hub_vnet_name     = "vnet-prod-hub"
hub_address_space = ["10.0.0.0/16"]
hub_subnets = {
  AzureFirewallSubnet = { address_prefix = "10.0.0.0/26" }
  GatewaySubnet       = { address_prefix = "10.0.0.64/26" }
  shared-services     = { address_prefix = "10.0.1.0/24" }
}

spoke_vnet_name     = "vnet-prod-spoke"
spoke_address_space = ["10.10.0.0/16"]
spoke_subnets = {
  app  = { address_prefix = "10.10.1.0/24" }
  data = { address_prefix = "10.10.2.0/24" }
}

enable_bastion        = true
bastion_subnet_prefix = "10.0.2.0/27"

key_vault_name   = "kv-prod-shared1234"
kv_rbac_enabled  = true

allowed_locations = ["East US", "West US", "Central US"]
enforce_policies  = false

reader_object_ids      = []
contributor_object_ids = []
