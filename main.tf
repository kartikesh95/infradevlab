terraform {
  backend "azurerm" {
    resource_group_name  = "kartikeshn-tfstate"
    storage_account_name = "kartikeshntfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "5rW0sSZmjMPQFxc6/nH15QUGlYrMfLDu5Nr8uiqBsD3WWLcXz542qBdIo0ApA8smTk6cZ6hIkFuX+AStLui2Nw=="
  }

  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 2.4.1"
    }
  }
}
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
data "azurerm_client_config" "current" {}

# Create our Resource Group - Jonnychipz-RG
resource "azurerm_resource_group" "rg" {
  name     = "kartikeshn-app001"
  location = "UK South"
}

# Create our Virtual Network - kartikeshn-VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "kartikeshn-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create our Subnet to hold our VM - Virtual Machines
resource "azurerm_subnet" "sn" {
  name                 = "VM"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
