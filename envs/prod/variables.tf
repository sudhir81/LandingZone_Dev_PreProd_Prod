variable "subscription_id_raw" {
  description = "Azure Subscription GUID"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
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

variable "law_name"           { type = string }
variable "law_retention_days" { type = number }

variable "central_storage_account_name" { type = string }

variable "hub_vnet_name"     { type = string }
variable "hub_address_space" { type = list(string) }
variable "hub_subnets" {
  type = map(object({
    address_prefix = string
  }))
}

variable "enable_bastion"        { type = bool }
variable "bastion_subnet_prefix" { type = string }

variable "spoke_vnet_name"     { type = string }
variable "spoke_address_space" { type = list(string) }
variable "spoke_subnets" {
  type = map(object({
    address_prefix = string
  }))
}

variable "key_vault_name"   { type = string }
variable "kv_rbac_enabled"  { type = bool }

variable "reader_object_ids"      { type = list(string) }
variable "contributor_object_ids" { type = list(string) }

variable "allowed_locations" { type = list(string) }
variable "enforce_policies"  { type = bool }
