terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "satfdev000"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}
