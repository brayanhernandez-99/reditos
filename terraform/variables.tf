variable "region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "vpc_reditos" {
  description = "CIDR block de la VPC para el proyecto Reditos"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_snet_reditos" {
  description = "CIDR block de la subred pública en Reditos"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone_1" {
  description = "Nombre de la AZs para RDS"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Nombre de la AZs para RDS"
  type        = string
  default     = "us-east-1b"
}

variable "private_snet_reditos_az_1" {
  description = "CIDR block de la subred privada en distintas AZs para RDS"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_snet_reditos_az_2" {
  description = "CIDR block de la subred privada en distintas AZs para RDS"
  type        = string
  default     = "10.0.3.0/24"
}

variable "ec2_instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "ID de la Amazon Machine Image (AMI) para la instancia EC2"
  type        = string
}

variable "ssh_key_name" {
  description = "Nombre del par de claves SSH para acceso a EC2"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña del usuario administrador de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_instance_type" {
  description = "Tipo de instancia para RDS"
  type        = string
  default     = "db.t3.micro"
}
