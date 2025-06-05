module "network" {
  source                    = "./modules/network"
  vpc_reditos               = var.vpc_reditos
  public_snet_reditos       = var.public_snet_reditos
  availability_zone_1       = var.availability_zone_1 
  availability_zone_2       = var.availability_zone_2 
  private_snet_reditos_az_1 = var.private_snet_reditos_az_1
  private_snet_reditos_az_2 = var.private_snet_reditos_az_2
}

module "ec2" {
  source              = "./modules/ec2"
  public_snet_reditos = module.network.public_reditos_id
  ec2_sg_reditos_ids  = module.network.ec2_sg_reditos_ids
  ec2_instance_type   = var.ec2_instance_type
  ami_id              = var.ami_id
  ssh_key_name        = var.ssh_key_name
}

module "rds" {
  source              = "./modules/rds"
  private_reditos_ids = module.network.private_reditos_ids
  rds_sg_reditos_ids  = module.network.rds_sg_reditos_ids
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  db_instance_type    = var.db_instance_type
}
