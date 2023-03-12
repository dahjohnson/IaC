# Terraform: Using Local Modules to Create a Two-Tier Architecture

![two-tier-terraform drawio](https://user-images.githubusercontent.com/116639830/224202753-ece3f9ac-336a-491c-a598-cb5cf35dd7d1.png)

- [Medium Blog Walkthrough](https://medium.com/@dahmearjohnson/terraform-using-local-modules-to-create-a-two-tier-architecture-d4e9c2f24b47 "<terraform-using-local-modules-to-create-a-two-tier-architecture-d4e9c2f24b47> Medium Blog Walkthrough")

## Objectives:

### - Create a highly available Two-Tier AWS architecture using a Local Terraform Module.
### - Create 2 Public Subnets for the Web Server Tier and 2 Private Subnets for the RDS Tier.
### - Configure routing and security groups for the Web Server and RDS Tier resources.
### - Deploy EC2 instances running Apache with custom web pages in each Public Web Tier subnet.
### - Create an Internet-facing Application Load Balancer targeting the web servers.
### - Deploy an RDS MySQL instance and a Standby instance (Multi-AZ) in the Private RDS Tier Subnets.

## Prerequisites:

### - Basic Terraform Knowledge
### - AWS account with Administrator Access permissions
### - AWS CLI installed and configured with your programmatic access credentials
### - Terraform installed (version ~> 1.3.0)

## Commands Used:

### Initialize working directory and backend
`terraform init`

### Resolve Terraform code formatting issues
`terraform fmt`

### Validate Terraform code
`terraform validate`

### Preview changes Terraform plans to make
`terraform plan`

### Apply changes
terraform apply -auto-approve -var=db_password=<your RDS db password>

### Verify reachability to external Application Load Balancer
`curl <alb_public_url>`

### List Terraform outputs
`terraform output`

### SSH to EC2 Web Server
`ssh -i MySSHKey.pem ubuntu@<EC2 public IP>`

### Connect to MySQL instance from Web Server
`mysql --host=<database_endpoint_address> --user=<master db username> -p`

### List databases
`SHOW DATABASES;`

### Tear down infrastructure deployed by Terraform
`terraform destroy -auto-approve -var=db_password=<your db password>`
