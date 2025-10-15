terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.47.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.6.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.7.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id_raw
  tenant_id       = var.tenant_id
}
