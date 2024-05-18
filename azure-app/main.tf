terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "gh-actions" {
  # az group list --output table
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
  name     = "gh-actions"
  location = "eastus"
}


// see private notes for setup before can use terraform
