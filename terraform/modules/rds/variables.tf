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
