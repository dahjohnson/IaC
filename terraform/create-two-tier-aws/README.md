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
