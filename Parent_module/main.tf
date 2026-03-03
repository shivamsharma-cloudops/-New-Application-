module "rg_name" {
  source              = "../Child_module/azurerm_rg"
  resource_group_name = "todorg"
  location            = "central india"
}

module "vnet_name" {
  depends_on          = [module.rg_name]
  source              = "../Child_module/azurerm_vnet"
  virtual_network     = "todovnet"
  resource_group_name = "todorg"
  location            = "central india"
  address_space       = ["10.0.0.0/16"]

}
module "subnet_frontend" {
  depends_on          = [module.vnet_name]
  source              = "../Child_module/azurerm_frontend_subnet"
  subnet_name         = "todosubnet"
  resource_group_name = "todorg"
  virtual_network     = "todovnet"
}

module "public_ip" {
  depends_on          = [module.rg_name]
  source              = "../Child_module/azurerm_pip"
  public_ip           = "todopip"
  resource_group_name = "todorg"
  location            = "central india"
  allocation_method   = "Static"
}
module "nsg_name" {
  depends_on          = [module.rg_name]
  source              = "../Child_module/azurerm_nsg"
  nsg_name            = "todonsg"
  resource_group_name = "todorg"
  location            = "central india"
}

module "nic" {
  depends_on          = [module.subnet_frontend, module.public_ip]
  source              = "../Child_module/azurerm_nic"
  network_interface   = "todonic"
  resource_group_name = "todorg"
  location            = "central india"
  subnet_id           = module.subnet_frontend.subnet_id
  pip_id              = module.public_ip.pip_id

}
module "frontend_vm" {
  depends_on          = [module.nic, module.nsg_name, module.public_ip]
  source              = "../Child_module/azurerm_frontend_vm"
  vm_name             = "todovm"
  resource_group_name = "todorg"
  location            = "central india"
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  # admin_password      = 
  nic_id = module.nic.network_interface_id
}

module "todokakeyvault" {
  depends_on          = [module.rg_name]
  source              = "../Child_module/azurerm_keyvault"
  keyvaultname        = "todokeyvault"
  resource_group_name = "todorg"
  location            = "central india"

}

module "keyvaultsecret1" {
  depends_on          = [module.todokakeyvault]
  source              = "../Child_module/azurerm_keyvault_secret"
  keyvaultsecretname  = "bankvault"
  keyvaultsecretvalue = "Password@6396900"
}