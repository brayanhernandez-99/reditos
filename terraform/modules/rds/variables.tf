variable "private_reditos_id" {
  description = "ID de la subred privada donde se lanzará la instancia EC2"
  type        = list
}

variable "rds_sg_reditos_id" {
  description = "ID del security group la subred privada donde se lanzará la instancia EC2"
  type        = list
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
