################################################################################
# Terraform and Provider Blocks
################################################################################

terraform {
  required_providers {
    aws = {
      version = "~> 4.55"
      source  = "hashicorp/aws"
    }
  }

  required_version = "~> 1.3.0"
}

provider "aws" {
  region = var.aws_region
}