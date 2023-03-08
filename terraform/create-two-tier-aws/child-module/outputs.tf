################################################################################
# Outputs
################################################################################

output "web_server_public_ip" {
  description = "Public IP of Web Servers"
  value       = [for i in aws_instance.web_server[*] : i.public_ip]
}

output "ec2_ssh_access" {
  description = "SSH Remote Access to the first EC2 instance"
  value       = "ssh -i ${aws_key_pair.generated.key_name}.pem ubuntu@${aws_instance.web_server[0].public_ip}"
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.db_instance.db_name
}

output "db_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.db_instance.address
}

output "connect_to_database" {
  description = "Command to connect to database from EC2"
  value       = "mysql --host=${aws_db_instance.db_instance.address} --user=${var.db_username} -p"
}

output "alb_public_url" {
  description = "Public URL for Application Load Balancer"
  value       = aws_lb.alb.dns_name
}