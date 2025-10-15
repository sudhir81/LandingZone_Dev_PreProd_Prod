resource "azurerm_resource_group" "core" {
  name     = "rg-${var.env}-core"
  location = var.location
  tags     = var.tags
}
