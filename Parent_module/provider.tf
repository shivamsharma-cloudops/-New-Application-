terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.62.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a549e772-d401-4859-917b-3cfe50a53e32"
}