resource "aws_instance" "ec2_reditos" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.public_snet_reditos
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.ec2_sg_reditos_ids
  tags = {
    Name = "ec2_reditos"
  }
}
