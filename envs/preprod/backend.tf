terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-preprod"
    storage_account_name = "satfpp000"
    container_name       = "tfstate"
    key                  = "preprod.tfstate"
  }
}
