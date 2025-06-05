variable "vpc_reditos" {
  description = "CIDR block de la VPC para el proyecto Reditos"
  type        = string
  default     = "10.0.0.0/16"
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

variable "public_snet_reditos" {
  description = "CIDR block de la subred pública en Reditos"
  type        = string
  default     = "10.0.1.0/24"
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
