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
}

resource "azurerm_subnet" "subA" {
    name           = "subnetA"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnetA.name
    address_prefixes = ["10.0.0.0/24"]
  }

resource "azurerm_virtual_network" "vnetB" {
  name                = "vnetB"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.1.0.0/23"]
}

resource "azurerm_subnet" "subB" {
    name           = "subnetB"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnetB.name
    address_prefixes = ["10.1.1.0/24"]
  }

resource "azurerm_virtual_network" "vnetC" {
  name                = "vnetC"
  location            = "West Europe"
  resource_group_name = "JulkaTest1"
  address_space       = ["10.2.0.0/23"]
}
resource "azurerm_subnet" "subC" {
    name           = "subnetC"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnetC.name
    address_prefixes = ["10.2.0.0/24"]
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

resource "azurerm_route_table" "routetableA" {
  name                          = "RouteTableA"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name           = "To-C"
    address_prefix = "10.2.0.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.0.4"
  }
}

resource "azurerm_subnet_route_table_association" "sub1rt" {
  subnet_id      = azurerm_subnet.subA.id
  route_table_id = azurerm_route_table.routetableA.id
}

resource "azurerm_route_table" "routetableC" {
  name                          = "RouteTableC"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name           = "To-A"
    address_prefix = "10.0.0.0/20"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.0.4"
  }
}

resource "azurerm_subnet_route_table_association" "sub2rt" {
  subnet_id      = azurerm_subnet.subC.id
  route_table_id = azurerm_route_table.routetableA.id
}