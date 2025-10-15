terraform {
  backend "azurerm" {
    resource_group_name  = "rg-gptfstate"
    storage_account_name = "tfstateg"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
  }
}
