resource "aws_db_instance" "db_reditos" {
  identifier             = var.db_name
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = var.db_instance_type
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = var.rds_sg_reditos_id
  db_subnet_group_name   = aws_db_subnet_group.db_snetg_reditos.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name = "db_reditos"
  }
}

resource "aws_db_subnet_group" "db_snetg_reditos" {
  name       = "rds-subnet-group-reditos"
  subnet_ids = var.private_reditos_id
  tags = {
    Name = "db_snetg_reditos"
  }
}
