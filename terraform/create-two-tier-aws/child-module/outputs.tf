output "web_server_public_ip" {
  description = "Public IP of Web Servers"
  value       = [for i in aws_instance.web_server[*] : i.public_ip]
}

output "web_server_public_dns" {
  description = "Public DNS name of Web Servers"
  value       = [for i in aws_instance.web_server[*] : i.public_dns]
}