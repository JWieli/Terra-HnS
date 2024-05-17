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

resource "azurerm_virtual_network" "vnetA" {
  name                = "vnetA"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.0.0.0/23"]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.0.0/24"
  }
}

resource "azurerm_virtual_network" "vnetB" {
  name                = "vnetB"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.1.0.0/23"]

  subnet {
    name           = "subnetB"
    address_prefix = "10.1.1.0/24"
  }
}

resource "azurerm_virtual_network" "vnetC" {
  name                = "vnetC"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.2.0.0/23"]

  subnet {
    name           = "subnetC"
    address_prefix = "10.2.0.0/24"
  }
}

resource "azurerm_virtual_network_peering" "VnetA-VnetB" {
  name                      = "VnetAVnetB"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnetA.name
  remote_virtual_network_id = azurerm_virtual_network.vnetB.id
}

resource "azurerm_virtual_network_peering" "VnetC-VnetB" {
  name                      = "VnetCVnetB"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnetC.name
  remote_virtual_network_id = azurerm_virtual_network.vnetB.id
}

resource "azurerm_virtual_network_peering" "VnetB-VnetA" {
  name                      = "VnetAVnetB"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnetB.name
  remote_virtual_network_id = azurerm_virtual_network.vnetA.id
}

resource "azurerm_virtual_network_peering" "VnetB-VnetC" {
  name                      = "VnetCVnetB"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnetB.name
  remote_virtual_network_id = azurerm_virtual_network.vnetC.id
}