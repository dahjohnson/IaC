# Terraform: Deploying an External Load Balancer with a Private Auto-Scaling Group

![luit-week21-terraform-project](https://user-images.githubusercontent.com/116639830/222899916-7f79e46f-c32f-448a-942a-63265cb82387.png)

- [Medium Blog Walkthrough](https://medium.com/towards-aws/terraform-deploying-an-external-load-balancer-with-a-private-auto-scaling-group-ef709990d5a7 "<terraform-deploying-an-external-load-balancer-with-a-private-auto-scaling-group-ef709990d5a7> Medium Blog Walkthrough")

## Objectives:
    
### - Create a custom VPC with 2 public and private subnets, a public and private route table, a NAT Gateway in the public subnet, and an Internet Gateway for outbound Internet traffic.
### - Add an Application Load Balancer (ALB) in the public subnets in front of the EC2 Auto-Scaling group.
### - Create a security group for the ALB that allows HTTP traffic from the Internet.
### - Create an Auto-Scaling group that deploys a minimum of 2 and a maximum of 5 EC2 instances.
### - Include a user data script in the Launch Template to install an Apache web server on the Auto-Scaling group.
### - Create an Auto-scaling group security group to only allow traffic from the ALB.
### - Output the public DNS of the ALB and then verify reachability to the Web server via the URL
### - Verify everything is working by using AWS CLI commands to terminate one of the instances and confirm that another one spins up to meet the minimum requirement of 2 instances.

## Prerequisites:

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
`terraform apply -auto-approve [optional -var=aws_region=<region>]`

### Verify reachability to external Application Load Balancer
`curl <alb_public_url>`

### List resources managed by state file
`terraform state list`

### Obtain Auto-Scaling Group name
`terraform state show aws_autoscaling_group.auto_scaling_group`

### Display Auto-Scaling Group Instance IDs
`aws autoscaling describe-auto-scaling-groups \
--auto-scaling-group-name <autoscaling-group name> \
--query 'AutoScalingGroups[*].Instances[?HealthStatus==`Healthy`].InstanceId' \
--region <aws_region> --output table`

### Terminate an Instance 
`aws ec2 terminate-instances --region <aws_region> \
--instance-ids <instance id>`

### Tear down infrastructure deployed by Terraform
`terraform destroy -auto-approve [optional -var=aws_region=<region>]`
