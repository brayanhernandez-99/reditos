terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source              = "./modules/network"
  vpc_cidr            = var.vpc_reditos
  public_subnet_cidr  = var.public_snet_reditos
  private_subnet_cidr = var.private_snet_reditos
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.network.public_reditos_id
  security_group_id = module.network.ec2_sg_reditos_id
  instance_type     = var.ec2_instance_type
  ami_id            = var.ami_id
  key_name          = var.ssh_key_name
}

module "rds" {
  source                  = "./modules/rds"
  subnet_ids              = module.network.private_reditos_id
  vpc_security_group_ids  = [module.network.rds_sg_reditos_id]
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  instance_class          = var.db_instance_type
}
