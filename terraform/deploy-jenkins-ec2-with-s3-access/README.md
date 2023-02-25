# Deploy an EC2 instance with Jenkins installed using Terraform

![deploy-ec2-w-jenkins-terraform](https://user-images.githubusercontent.com/116639830/221373512-694cc740-8432-44f8-8490-70edbb65f3e5.png)

- [Medium Blog Walkthrough](https://medium.com/aws-in-plain-english/deploy-an-ec2-with-jenkins-installed-using-terraform-ac1495c813a2 "<deploy-an-ec2-with-jenkins-installed-using-terraform-ac1495c813a2> Medium Blog Walkthrough")

## Objectives:
    
### - Create a main.tf, providers.tf, variables.tf, and outputs.tf to manage your Terraform deployment.
### - Deploy 1 EC2 Instance (Amazon Linux 2) into a new VPC.
### - Bootstrap the EC2 instance with a script that will install and start Jenkins.
### - Create and assign a Security Group to the Jenkins Server that allows traffic on port 22 from your Public IP and allows traffic from port 8080.
### - Create an S3 bucket for your Jenkins Artifacts that is not open to the public.
### - Create an Instance Profile allowing S3 write access for the Jenkins Server and assign the role to your Jenkins Server EC2 instance.

## Prerequisites:

### - AWS account with Administrator Access permissions
### - Pregenerated SSH Key for EC2 remote access on your local machine
### - AWS CLI installed and configured with your programmatic access credentials
### - Terraform installed (version ≥ 1.3.0)

## NOTE:
### In the variables.tf file you must change the "ssh_key_name" and "bucket_name" variable block to match your environment needs

## Commands Used:

### Initialize working directory and backend
`terraform init`

### Preview changes Terraform plans to make
`terraform plan`

### Apply changes
`terraform apply`

### Output Terraform state file
`terraform show`

### List resources managed by state file
`terraform state list`

### Display Terraform state of a specific resource
`terraform state show <resource_name>`

### View Terraform Outputs
`terraform output`

### Tear down infrastructure deployed by Terraform
`terraform destory`
