# Terraform Variables

## VPC Variables

variable "vpc" {
  description = "VPC name"
  type        = string
  default     = "demo-vnet"
}

variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "172.16.0.0/16"
}

variable "internet_gateway" {
  description = "Internet Gateway name"
  type        = string
  default     = "demo-internetgateway"
}

variable "az_names" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet" {
  description = "Public Subnet name"
  type        = string
  default     = "demo-public-subnet"
}

variable "public_subnet_cidr" {
  description = "Public Subnet cidr block"
  type        = list(string)
  default     = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "private_subnet" {
  description = "Private Subnet name"
  type        = string
  default     = "demo-private-subnet"
}

variable "private_subnet_cidr" {
  description = "Private Subnet cidr block"
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.11.0/24"]
}

variable "public_route_table" {
  description = "Public Route Table name"
  type        = string
  default     = "demo-public-route-table"
}

variable "private_route_table" {
  description = "Private Route Table name"
  type        = string
  default     = "demo-private-route-table"
}

variable "elastic_ip" {
  description = "Elastic IP Name"
  type        = string
  default     = "demo-nat-elastic-ip"
}

variable "nat_gateway" {
  description = "Nat Gateway Name"
  type        = string
  default     = "demo-nat-gateway"
}

# Security Group Variables

variable "alb_security_group" {
  description = "ALB Security Group name"
  type        = string
  default     = "alb-security_group"
}

variable "asg_security_group" {
  description = "ASG Security Group name"
  type        = string
  default     = "asg-security-group"
}

# Launch Template and ASG Variables

variable "launch_template" {
  description = "Launch Template Name"
  type        = string
  default     = "demo-launch-template"
}

variable "ami" {
  description = "ami id"
  type        = string
  default     = "ami-0557a15b87f6559cf"
}

variable "instance_type" {
  description = "launch template EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "launch_template_ec2" {
  description = "launch template EC2 name"
  type        = string
  default     = "demo-asg-ec2"
}

# ALB Variables

variable "alb" {
  description = "Application Load Balancer name"
  type        = string
  default     = "demo-external-alb"
}

variable "target_group" {
  description = "Application Load Balancer Target Group name"
  type        = string
  default     = "alb-target-group"
}

