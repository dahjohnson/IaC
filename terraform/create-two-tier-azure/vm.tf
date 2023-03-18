################################################################################
# SSH Keys
################################################################################

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.generated.private_key_pem
  filename        = "${var.ssh_key}.pem"
  file_permission = "0400"
}

################################################################################
# Virtual Machines
################################################################################

resource "azurerm_public_ip" "mgmt_vm_pip" {
  name                = "${var.env}-mgmt-vm-pip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.env
  }
}

resource "azurerm_network_interface" "mgmt_vm_nic" {
  name                = "${var.env}-mgmt-vm-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.env}-internal"
    subnet_id                     = azurerm_subnet.mgmt_tier.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt_vm_pip.id
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_linux_virtual_machine" "mgmt_vm" {
  name                = "${var.env}-mgmt-vm"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin
  network_interface_ids = [
    azurerm_network_interface.mgmt_vm_nic.id
  ]

  admin_ssh_key {
    username   = var.vm_admin
    public_key = tls_private_key.generated.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_network_interface" "web_vm_nic" {
  for_each = local.zones

  name                = "${var.env}-web-vm-${each.value}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.env}-ip-config"
    subnet_id                     = azurerm_subnet.web_tier.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_linux_virtual_machine" "web_vm" {
  for_each = local.zones

  name                            = "${var.env}-web-vm-${each.value}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.vm_admin
  admin_password                  = var.vm_password
  disable_password_authentication = false
  zone                            = each.value
  custom_data                     = filebase64("./apache-install.sh")
  network_interface_ids = [
    azurerm_network_interface.web_vm_nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    environment = var.env
  }
}