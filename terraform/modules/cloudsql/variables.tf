variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  description = "Región para Cloud SQL"
  default     = "europe-west3"
}

variable "db_instance_name" {
  type        = string
  description = "Nombre de la instancia de Cloud SQL"
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos"
}

variable "db_user" {
  type        = string
  description = "Usuario administrador de la base de datos"
}

variable "db_password" {
  type        = string
  description = "Contraseña del usuario administrador"
  sensitive   = true
}

variable "credentials_file" {
  type        = string
  description = "Ruta al archivo de credenciales GCP"
}

# Usuario 1
variable "db_user1" {
  type        = string
  description = "Usuario1 de la aplicación con permisos read/write"
}

variable "db_password1" {
  type        = string
  description = "Contraseña del usuario1"
  sensitive   = true
}

# Usuario 2
variable "db_user2" {
  type        = string
  description = "Usuario2 de la aplicación con permisos read/write"
}

variable "db_password2" {
  type        = string
  description = "Contraseña del usuario2"
  sensitive   = true
}
