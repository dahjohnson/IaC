################################################################################
# Module
################################################################################

module "create_two_tier_aws" {
  source = "./child-module"

  env                       = var.env
  aws_region                = var.aws_region
  vpc_cidr_block            = "172.16.0.0/16"
  public_subnet_cidr_block  = ["172.16.0.0/24", "172.16.1.0/24"]
  private_subnet_cidr_block = ["172.16.10.0/24", "172.16.11.0/24"]

  ec2_name = var.ec2_name
  ssh_key  = var.ssh_key

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}