################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "resource_group" {
  name     = join("-", ["${var.env}", "resource-group"])
  location = var.location
}

################################################################################
# Virtual Network
################################################################################

resource "azurerm_virtual_network" "vnet" {
  name                = join("-", ["${var.env}", "vnet"])
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = var.vnet_cidr
  dns_servers         = var.vnet_dns

  tags = {
    environment = var.env
  }
}

################################################################################
# Subnets
################################################################################

resource "azurerm_subnet" "web_tier" {
  name                 = join("-", ["${var.env}", "web-subnet"])
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_tier_cidr
}

resource "azurerm_subnet" "app_tier" {
  name                 = join("-", ["${var.env}", "app-subnet"])
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_tier_cidr
}

resource "azurerm_subnet" "data_tier" {
  name                 = join("-", ["${var.env}", "data-subnet"])
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.data_tier_cidr
}

resource "azurerm_subnet" "mgmt_tier" {
  name                 = join("-", ["${var.env}", "mgmt-subnet"])
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.mgmt_tier_cidr
}