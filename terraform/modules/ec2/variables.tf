variable "ami_id" {
  description = "ID de la AMI que se usará para lanzar la instancia EC2"
  type        = string
}

variable "ec2_instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "public_subnet_reditos" {
  description = "ID de la subred pública donde se lanzará la instancia EC2"
  type        = string
}

variable "ssh_key_name" {
  description = "Nombre del par de claves SSH para acceso a EC2"
  type        = string
}
