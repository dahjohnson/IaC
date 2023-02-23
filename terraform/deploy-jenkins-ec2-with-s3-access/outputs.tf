# Terraform Outputs

output "instance_public_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_server.public_ip
}

output "s3_bucket_uri" {
  description = "S3 bucket URI"
  value       = "s3://${aws_s3_bucket.s3.id}"
}

output "bucket_domain_name" {
  description = "FQDN of bucket"
  value       = "https://${aws_s3_bucket.s3.bucket_domain_name}"
}
