# Terraform Outputs

output "alb_public_url" {
  description = "Public URL for Application Load Balancer"
  value       = aws_lb.alb.dns_name
}