terraform {
  required_version = ">= 1.5.0"
}

# --- Resource Groups ---
resource "azurerm_resource_group" "rg_mgmt" {
  name     = var.rg_names.management
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_net" {
  name     = var.rg_names.network
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_app" {
  name     = var.rg_names.workload
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_sec" {
  name     = var.rg_names.security
  location = var.location
  tags     = var.tags
}

# --- Log Analytics ---
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_mgmt.name
  retention_in_days   = var.law_retention_days
  sku                 = "PerGB2018"
  tags                = var.tags
}

# --- Storage (central) ---
resource "azurerm_storage_account" "central" {
  name                          = var.central_storage_account_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg_mgmt.name
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false
  tags                          = var.tags
}

# --- Networking: Hub ---
resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.hub_vnet_name
  address_space       = var.hub_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  tags                = var.tags
}

resource "azurerm_subnet" "hub_subnets" {
  for_each             = var.hub_subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg_net.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [each.value.address_prefix]
}

# Bastion (optional)
resource "azurerm_subnet" "bastion" {
  count                = var.enable_bastion ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg_net.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.bastion_subnet_prefix]
}

resource "azurerm_public_ip" "bastion" {
  count               = var.enable_bastion ? 1 : 0
  name                = "pip-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion" {
  count               = var.enable_bastion ? 1 : 0
  name                = "bastion-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[0].id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }

  tags = var.tags
}

# --- Networking: Spoke ---
resource "azurerm_virtual_network" "vnet_spoke" {
  name                = var.spoke_vnet_name
  address_space       = var.spoke_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_subnets" {
  for_each             = var.spoke_subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg_net.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [each.value.address_prefix]
}

# --- NSG (example) ---
resource "azurerm_network_security_group" "nsg_app" {
  name                = "nsg-spoke-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  tags                = var.tags

  security_rule {
    name                       = "Allow-HTTPS-Out"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "assoc_app" {
  subnet_id                 = azurerm_subnet.spoke_subnets["app"].id
  network_security_group_id = azurerm_network_security_group.nsg_app.id
}

# --- Diagnostics: Subscription Activity Logs -> LAW ---
resource "azurerm_monitor_diagnostic_setting" "sub_activity_logs" {
  name                       = "ds-sub-activitylogs"
  target_resource_id         = var.subscription_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log { category = "Administrative" }
  enabled_log { category = "Security" }
  enabled_log { category = "Policy" }
  enabled_log { category = "Autoscale" }
  enabled_log { category = "ResourceHealth" }

  lifecycle {
    ignore_changes = [metric]
  }
}

# --- Key Vault ---
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg_sec.name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  purge_protection_enabled      = true
  soft_delete_retention_days    = 7
  public_network_access_enabled = true
  rbac_authorization_enabled    = var.kv_rbac_enabled
  tags                          = var.tags
}

# --- RBAC on Workload RG (optional) ---
resource "azurerm_role_assignment" "workload_readers" {
  for_each             = toset(var.reader_object_ids)
  scope                = azurerm_resource_group.rg_app.id
  role_definition_name = "Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "workload_contributors" {
  for_each             = toset(var.contributor_object_ids)
  scope                = azurerm_resource_group.rg_app.id
  role_definition_name = "Contributor"
  principal_id         = each.value
}

# --- Policy: Allowed Locations (built-in) ---
resource "azapi_resource" "allowed_locations_assignment" {
  count     = length(var.allowed_locations) > 0 ? 1 : 0
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "allowed-locations-assignment"
  parent_id = var.subscription_id

  body = {
    properties = {
      displayName        = "Allowed Locations Policy"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
      enforcementMode    = var.enforce_policies ? "Default" : "DoNotEnforce"
      parameters = {
        listOfAllowedLocations = {
          value = var.allowed_locations
        }
      }
    }
  }
}

# --- Outputs ---
output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "resource_groups" {
  value = {
    management = azurerm_resource_group.rg_mgmt.name
    network    = azurerm_resource_group.rg_net.name
    workload   = azurerm_resource_group.rg_app.name
    security   = azurerm_resource_group.rg_sec.name
  }
}

output "vnet_ids" {
  value = {
    hub   = azurerm_virtual_network.vnet_hub.id
    spoke = azurerm_virtual_network.vnet_spoke.id
  }
}
