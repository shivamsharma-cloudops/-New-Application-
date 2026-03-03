resource "azurerm_virtual_network" "vnet1" {
  name = var.virtual_network
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = var.address_space
}