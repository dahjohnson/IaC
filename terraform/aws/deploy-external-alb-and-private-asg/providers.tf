# Terraform Providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55"
    }
  }

  required_version = "~> 1.3.0"
}

provider "aws" {
  region = var.aws_region
}
