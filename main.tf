terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = "West Europe"
  name     = "JulkaTest1"
  tags = {
    environment = "development"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetA"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetB"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnetB"
    address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetC"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnetC"
    address_prefix = "10.0.1.0/24"
  }
}
