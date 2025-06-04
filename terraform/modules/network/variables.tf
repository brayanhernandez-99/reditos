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

variable "private_snet_reditos" {
  description = "CIDR block de la subred privada en Reditos"
  type        = string
  default     = "10.0.2.0/24"
}
