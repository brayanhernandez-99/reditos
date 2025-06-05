output "network_reditos_id" {
  value = aws_vpc.vpc_reditos.id
}

output "public_reditos_id" {
  value = aws_subnet.public_snet_reditos.id
}

output "ec2_sg_reditos_ids" {
  value = [aws_security_group.ec2_sg_reditos.id]
}

output "private_reditos_ids" {
  value = [
    aws_subnet.private_snet_reditos_az_1.id,
    aws_subnet.private_snet_reditos_az_2.id
  ]
}

output "rds_sg_reditos_ids" {
  value = [
    aws_security_group.rds_sg_reditos_az_1.id,
    aws_security_group.rds_sg_reditos_az_2.id
  ]
}
