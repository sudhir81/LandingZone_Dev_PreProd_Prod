terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-prod"
    storage_account_name = "satfprod000"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
  }
}
