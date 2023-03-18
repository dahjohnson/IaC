################################################################################
# Network Security Groups
################################################################################

# Obtain User's Local Public IP

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

resource "azurerm_network_security_group" "mgmt_nsg" {
  name                = "${var.env}-mgmt-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "Allow-User-Public-IP-for-SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${data.external.myipaddr.result.ip}/32"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_subnet_network_security_group_association" "mgmt_nsg_assoc" {
  subnet_id                 = azurerm_subnet.mgmt_tier.id
  network_security_group_id = azurerm_network_security_group.mgmt_nsg.id
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = "${var.env}-web-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_subnet_network_security_group_association" "web_nsg_assoc" {
  subnet_id                 = azurerm_subnet.web_tier.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}