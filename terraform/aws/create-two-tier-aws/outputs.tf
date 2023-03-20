################################################################################
# Outputs
################################################################################

output "web_server_public_ip" {
  description = "Public IP of Web Servers"
  value       = module.create_two_tier_aws.web_server_public_ip
}

output "ec2_ssh_access" {
  description = "Remote Access to EC2"
  value       = module.create_two_tier_aws.ec2_ssh_access
}

output "db_name" {
  description = "Database Name"
  value       = module.create_two_tier_aws.db_name
}

output "db_address" {
  description = "The hostname of the RDS instance"
  value       = module.create_two_tier_aws.db_address
}

output "alb_public_url" {
  description = "Public URL for Application Load Balancer"
  value       = module.create_two_tier_aws.alb_public_url
}

output "connect_to_database" {
  description = "Command to connect to database from EC2"
  value       = module.create_two_tier_aws.connect_to_database
}