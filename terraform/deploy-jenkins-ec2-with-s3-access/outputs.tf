

output "instance_public_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_server.public_ip
}

output "s3_bucket_url" {
  description = "URL for S3 bucket"
  value       = aws_s3_bucket.s3.id
}