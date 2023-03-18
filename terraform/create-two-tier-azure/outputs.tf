################################################################################
# Outputs
################################################################################

output "lb_pip" {
  description = "Public IP of Azure Load Balancer"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "mgmt_vm_pip" {
  description = "Public IP of MGMT VM"
  value       = azurerm_public_ip.mgmt_vm_pip.ip_address
}