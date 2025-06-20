region                      = "us-east-1"
availability_zone_1         = "us-east-1a"
availability_zone_2         = "us-east-1b"

vpc_reditos                 = "10.0.0.0/16"
public_snet_reditos         = "10.0.1.0/24"
private_snet_reditos_az_1   = "10.0.2.0/24"
private_snet_reditos_az_2   = "10.0.3.0/24"

ec2_instance_type           = "t2.micro"
ami_id                      = "ami-0fc5d935ebf8bc3bc"
ssh_key_name                = "reditos-ssh-key"
db_name                     = "reditos"
db_username                 = "admin"
db_password                 = "reditos123"
db_instance_type            = "db.t3.micro"
