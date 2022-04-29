terraform {
  backend "azurerm" {
    resource_group_name  = "kartikeshn-tfstate"
    storage_account_name = "kartikeshntfstate"
    container_name       = "tfstate"
    key                  = "tf/terraform.tfstate"
    access_key           = "kgV/Lm1yzv/AJwrlgTCXOGn9zcEPbHkfIx9sHymxUIqTb8cQRm0PINK2Dcc3A+5YOOQmb5jB3NA39ZM6FexfCw=="
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
/*
# Create our Azure Storage Account - kartikeshnsa
resource "azurerm_storage_account" "kartikeshnsa" {
  name                     = "kartikeshnsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "dev1"
  }
}
# Create our vNIC for our VM and assign it to our Virtual Machines Subnet
resource "azurerm_network_interface" "vmnic" {
  name                = "kartikeshnvm01nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.4"
  }
}
# Create our Virtual Machine - Kartikeshn-VM01
resource "azurerm_virtual_machine" "kartikeshn-vm01" {
  name                  = "kartikeshnvm01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = "Standard_B2s"
  delete_os_disk_on_termination  = true
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }
  storage_os_disk {
    name              = "kartikeshnvm01osnew"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "kartikeshnvm01"
    admin_username = "kartikeshn"
    admin_password = "Password123$"
  }
  os_profile_windows_config {
  }
}
*/