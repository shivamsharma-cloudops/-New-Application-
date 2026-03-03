resource "azurerm_network_interface" "nic1" {
  name                = var.network_interface
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnetdatablock.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pipdatablock.id
  }
}

data "azurerm_subnet" "subnetdatablock" {
  name = "todosubnet"
  resource_group_name = "todorg"
virtual_network_name = "todovnet"
}
data "azurerm_public_ip" "pipdatablock" {
  name                = "todopip"
  resource_group_name = "todorg"
}