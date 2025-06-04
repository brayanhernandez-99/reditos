resource "aws_vpc" "vpc_reditos" {
  cidr_block = var.vpc_reditos
}

resource "aws_subnet" "public_snet_reditos" {
  vpc_id                  = aws_vpc.vpc_reditos.id
  cidr_block              = var.public_snet_reditos
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_snet_reditos" {
  vpc_id     = aws_vpc.vpc_reditos.id
  cidr_block = var.private_snet_reditos
}

resource "aws_security_group" "ec2_sg_reditos" {
  vpc_id = aws_vpc.vpc_reditos.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_sg_reditos"
  }
}

resource "aws_security_group" "rds_sg_reditos" {
  vpc_id = aws_vpc.vpc_reditos.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg_reditos.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rds_sg_reditos"
  }
}
