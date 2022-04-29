terraform {
data "terraform_remote_state" "remstate" {
  backend = "azurerm"
  config = {
    storage_account_name = "kartikeshntfstate"
    container_name       = "tfstate"
    key                  = "tf/terraform.tfstate"
  }
}
 /*backend "azurerm" {
 //   resource_group_name  = "kartikeshn-tfstate"
    storage_account_name = "kartikeshntfstate"
    container_name       = "tfstate"
    key                  = "tf/terraform.tfstate"
    access_key           = "kgV/Lm1yzv/AJwrlgTCXOGn9zcEPbHkfIx9sHymxUIqTb8cQRm0PINK2Dcc3A+5YOOQmb5jB3NA39ZM6FexfCw=="
  }*/

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
