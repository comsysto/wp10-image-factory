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
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}

provider "github" {
}

provider "external" {
}