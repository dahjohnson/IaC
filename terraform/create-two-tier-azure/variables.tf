################################################################################
# Variables
################################################################################


# Locals

locals {
  zones = toset(["1", "2"])
}

# Environment Variables

variable "env" {
  description = "Environment Name"
  type        = string
}

variable "location" {
  description = "Deployment Location"
  type        = string
  default     = "East US"
}

# VNET Variables

variable "vnet_cidr" {
  description = "VNET CIDR block"
  type        = list(string)
  default     = ["10.100.0.0/22"]
}

variable "vnet_dns" {
  description = "VNET DNS servers"
  type        = list(string)
  default     = []
}

variable "web_tier_cidr" {
  description = "Web Tier Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.100.0.0/24"]
}

variable "app_tier_cidr" {
  description = "App Tier Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.100.1.0/24"]
}

variable "data_tier_cidr" {
  description = "Data Tier Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.100.2.0/24"]
}

variable "mgmt_tier_cidr" {
  description = "MGMT Tier Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.100.3.0/24"]
}

# VM Variables

variable "vm_size" {
  description = "VM instance size"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "storage_image_reference" {
  description = "VM image"
  type        = list(any)
  default = [
    "Canonical",
    "0001-com-ubuntu-server-jammy",
    "22_04-lts-gen2",
    "latest"
  ]
}

variable "vm_admin" {
  description = "VM admin user name"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "VM admin user password"
  type        = string
  sensitive   = true
}

variable "ssh_key" {
  description = "SSH Key for VM remote access"
  type        = string
  default     = "AzureSSHKey"
}