variable "environment" {
  description = "Environment name (dev/preprod/prod)"
  type        = string
}

variable "subscription_id" {
  description = "Subscription resource ID (format: /subscriptions/<id>)"
  type        = string
}

variable "tenant_id" {
  description = "AAD Tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "rg_names" {
  type = object({
    management = string
    network    = string
    workload   = string
    security   = string
  })
}

variable "law_name" {
  type        = string
  description = "Log Analytics workspace name"
}

variable "law_retention_days" {
  type        = number
  default     = 30
}

variable "central_storage_account_name" {
  type        = string
  description = "Central storage account name (must be globally unique, lower-case)"
}

variable "hub_vnet_name" {
  type        = string
}

variable "hub_address_space" {
  type        = list(string)
}

variable "hub_subnets" {
  type = map(object({
    address_prefix = string
  }))
}

variable "enable_bastion" {
  type    = bool
  default = true
}

variable "bastion_subnet_prefix" {
  type        = string
  description = "CIDR for AzureBastionSubnet when enable_bastion=true"
  default     = "10.0.2.0/27"
}

variable "spoke_vnet_name" {
  type = string
}

variable "spoke_address_space" {
  type = list(string)
}

variable "spoke_subnets" {
  type = map(object({
    address_prefix = string
  }))
}

variable "key_vault_name" {
  type        = string
  description = "Key Vault name (globally unique)"
}

variable "kv_rbac_enabled" {
  type    = bool
  default = true
}

variable "reader_object_ids" {
  type    = list(string)
  default = []
}

variable "contributor_object_ids" {
  type    = list(string)
  default = []
}

variable "allowed_locations" {
  type    = list(string)
  default = []
}

variable "enforce_policies" {
  type    = bool
  default = false
}
