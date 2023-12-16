terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.68.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

variable "rgpurpose" {
  default = "networkconfigs"
}

variable "env" {
  default = "prd"
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.0"
  prefix = ["${var.rgpurpose}", "${var.env}"]
}

resource "azurerm_resource_group" "main" {
  name = "az-${module.naming.resource_group.name}"
  location = "centralus"
}

resource "azurerm_public_ip" "maim" {
  name = module.naming.public_ip.name
  location = "centralus"
  sku = "Standard"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.main.name
}