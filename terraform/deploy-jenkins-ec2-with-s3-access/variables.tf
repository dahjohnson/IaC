# VPC Variables

variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16" 
}

variable "vpc_tag" {
  description = "Name tag for VPC"
  type        = string
  default     = "Demo-VPC" 
}

variable "subnet_tag" {
  description = "Name tag for Subnet"
  type        = string
  default     = "Demo-Subnet" 
}

variable "subnet_cidr" {
  description = "Subnet cidr block"
  type        = string
  default     = "10.0.0.0/24" 
}

variable "internet_gateway_tag" {
  description = "Name tag for Internet Gateway"
  type        = string
  default     = "Demo-Internet-Gateway" 
}

# IAM Role Variables

variable "ec2_role_name" {
  description = "IAM role name for Jenkins EC2"
  type        = string
  default     = "Jenksins_EC2_Server_IAM_Role" 
}

variable "ec2_instance_profile_name" {
  description = "IAM instance profile name for Jenkins EC2"
  type        = string
  default     = "Jenkins_EC2_Server_Instance_Profile"
}

variable "ec2_role_policy_name" {
  description = "IAM role policy name for Jenkins EC2"
  type        = string
  default     = "Jenkins_EC2_Role_Policy"
}

variable "ec2-trust-policy" {
  description = "sts assume role policy for EC2"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }   
    ]
}
    EOF  
}

variable "ec2-s3-permissions" {
  description = "IAM permissions for EC2 to S3"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "*"
        }
    ]
}
  EOF
}

# S3 Variables

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "terraform1demo1s3bucket2023"
}

# Security Group Variables

variable "security_group_name" {
  description = "Name for Jenkins Security Group"
  type        = string
  default     = "Jenkins Security Group"
}

## External Data Source Block to Obtain User's Public IP and add to Security Group

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

# EC2 Variables

variable "ami" {
  description = "Jenkins EC2 machine image id"
  type        = string
  default     = "ami-0dfcb1ef8550277af" 
}

variable "instance_type" {
  description = "Jenkins EC2 instance type"
  type        = string
  default     = "t2.micro" 
}

variable "ssh_key_name" {
  description = "SSH key name for Jenkins EC2"
  type        = string
  default     = "ssh_key" 
}

variable "ec2_user_data" {
  description = "User data shell script for Jenkins EC2"
  type        = string
  default     = <<EOF
#!/bin/bash
# Install Jenkins and Java 
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo amazon-linux-extras install -y java-openjdk11 
sudo yum install -y jenkins
sudo systemctl daemon-reload

# Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Firewall Rules
if [[ $(firewall-cmd --state) = 'running' ]]; then
    YOURPORT=8080
    PERM="--permanent"
    SERV="$PERM --service=jenkins"

    firewall-cmd $PERM --new-service=jenkins
    firewall-cmd $SERV --set-short="Jenkins ports"
    firewall-cmd $SERV --set-description="Jenkins port exceptions"
    firewall-cmd $SERV --add-port=$YOURPORT/tcp
    firewall-cmd $PERM --add-service=jenkins
    firewall-cmd --zone=public --add-service=http --permanent
    firewall-cmd --reload
fi
EOF
}

variable "ec2_tag" {
  description = "Name tag for Jenkins EC2"
  type        = string
  default     = "Jenkins-Server" 
}