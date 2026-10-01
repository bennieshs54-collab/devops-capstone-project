terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "../modules/azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    Project     = "DevOps-Capstone"
    Environment = "Demo"
    ManagedBy   = "Terraform"
  }
}