################################################################################
# Variables
################################################################################

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
}

variable "env" {
  description = "Environment Name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC IPv4 CIDR block"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "Public Subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidr_block" {
  description = "Private Subnet CIDR blocks"
  type        = list(string)
}

variable "ec2_name" {
  description = "EC2 Web Server name"
  type        = string
}

variable "ssh_key" {
  description = "ssh key name"
  type        = string
}

variable "user_data" {
  description = "User Data Shell script for Apache installation"
  type        = string
  default     = <<EOF
#!/bin/bash

# Install Apache on Ubuntu

sudo apt update -y
sudo apt install -y apache2
sudo apt install -y mysql-client

sudo systemctl start apache2
sudo systemctl enable apache2
EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo '<center><h1>This Amazon EC2 instance is located in Availability Zone: AZID </h1></center>' > /var/www/html/index.txt
sed "s/AZID/$EC2AZ/" /var/www/html/index.txt > /var/www/html/index.html
EOF
}

variable "db_allocated_storage" {
  description = "The allocated storage in gibibytes"
  type        = string
  default     = 10
}

variable "db_name" {
  description = "The database name"
  type        = string
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The database engine version to use"
  type        = string
  default     = "8.0.32"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.small"
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}