terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.15"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}