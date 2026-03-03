
data "azurerm_network_interface" "nicdatablock" {
  name                = "todonic"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "todokv" {
  name = "todokeyvault"
  resource_group_name = "todorg"

}
data "azurerm_key_vault_secret" "todosecret" {
  name = "bankvault"
  key_vault_id = data.azurerm_key_vault.todokv.id
}


resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
   admin_password      = data.azurerm_key_vault_secret.todosecret.value
     disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.nicdatablock.id
  ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install nginx -y
systemctl start nginx
systemctl enable nginx
EOF
)
}
