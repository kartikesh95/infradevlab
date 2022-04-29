terraform {
  backend "azurerm" {
    resource_group_name  = "kartikeshn-tfstate"
    storage_account_name = "kartikeshntfstate"
    container_name       = "tfstate"
    key                  = "tf/terraform.tfstate"
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
