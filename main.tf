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
  address_space       = ["10.0.0.0/23"]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.0.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetB"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.1.0.0/23"]

  subnet {
    name           = "subnetB"
    address_prefix = "10.1.1.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetC"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.2.0.0/23"]

  subnet {
    name           = "subnetC"
    address_prefix = "10.2.0.0/24"
  }
}
