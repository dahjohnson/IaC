variable "env" {
  description = "Environment Name"
  type        = string
  default     = "terraform-demo"
}

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-1"
}

variable "ec2_name" {
  description = "EC2 Web Server name"
  type        = string
  default     = "Web-Server"
}

variable "ssh_key" {
  description = "ssh key name"
  type        = string
  default     = "MySSHKey"
}

variable "db_name" {
  description = "The database name"
  type        = string
  default     = "terraformdatabase1"
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  default     = "blackTeam$23"
  sensitive   = true
}