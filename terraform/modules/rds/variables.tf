variable "private_reditos_ids" {
  description = "Lista de IDs de subredes privadas en distintas AZs para RDS"
  type        = list(string)
}

variable "rds_sg_reditos_ids" {
  description = "Lista de IDs del security group en distintas AZs para RDS"
  type        = list(string)
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
