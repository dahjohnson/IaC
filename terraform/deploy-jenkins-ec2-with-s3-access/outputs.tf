# Terraform Outputs

output "ec2_remote_access" {
  description = "EC2 Remote Access"
  value       = "ssh -i ${local_file.private_key_pem.filename} ec2-user@${aws_instance.jenkins_server.public_ip}"
}

output "instance_public_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = "Jenkins Server Public IP: ${aws_instance.jenkins_server.public_ip}"
}

output "s3_bucket_uri" {
  description = "S3 bucket URI"
  value       = "S3 Bucket URI: s3://${aws_s3_bucket.s3.id}"
}

output "s3_bucket_url" {
  description = "S3 Bucket URL"
  value       = "S3 Bucket URL: https://${aws_s3_bucket.s3.bucket_domain_name}"
}

output "user_local_public_IP" {
  description = "User's local public IP"
  value       = "User Local Public IP: ${data.external.myipaddr.result.ip}"
}