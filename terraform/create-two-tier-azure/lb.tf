################################################################################
# Load Balancer
################################################################################

resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.env}-lb-pip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.env
  }
}

resource "azurerm_lb" "lb" {
  name                = "${var.env}-Load-Balancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.env}-lb-frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "${var.env}-LB-Rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.env}-lb-frontend-ip"
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "http-probe"
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.env}-LB-BackEnd-Address-Pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_assoc" {
  for_each = local.zones

  network_interface_id    = azurerm_network_interface.web_vm_nic[each.key].id
  ip_configuration_name   = "${var.env}-ip-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}