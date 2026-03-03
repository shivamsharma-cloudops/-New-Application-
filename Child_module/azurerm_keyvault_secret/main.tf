
data "azurerm_key_vault" "key" {
  name                = "todokeyvault"
  resource_group_name =  "todorg"
}

 
resource "azurerm_key_vault_secret" "keyvaultsecret" {
  name         = var.keyvaultsecretname
    value        = var.keyvaultsecretvalue
  key_vault_id = data.azurerm_key_vault.key.id
}