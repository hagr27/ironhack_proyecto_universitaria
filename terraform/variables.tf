##############################################
# VARIABLES GENERALES DEL PROYECTO
##############################################

variable "project_id" {
  description = "ID del proyecto en Google Cloud"
  type        = string
}

variable "region" {
  description = "Región donde se desplegarán los recursos"
  type        = string
  default     = "europe-west3"
}

variable "credentials_file" {
  description = "Ruta local al archivo JSON de credenciales del servicio de GCP"
  type        = string
}

##############################################
# CONFIGURACIÓN DE CLOUD SQL
##############################################

variable "db_instance_name" {
  description = "Nombre único de la instancia de Cloud SQL"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos principal"
  type        = string
}

##############################################
# USUARIOS DE LA BASE DE DATOS
##############################################

variable "db_user" {
  description = "Usuario administrador de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
}

variable "db_user1" {
  description = "Usuario 1 de la aplicación (lectura/escritura)"
  type        = string
}

variable "db_password1" {
  description = "Contraseña del usuario 1"
  type        = string
  sensitive   = true
}

variable "db_user2" {
  description = "Usuario 2 de la aplicación (lectura/escritura)"
  type        = string
}

variable "db_password2" {
  description = "Contraseña del usuario 2"
  type        = string
  sensitive   = true
}

# variables.tf
variable "source_dir" {
  description = "Ruta local donde se encuentra el código de la Cloud Function"
  type        = string
}

# kaggle
variable "kaggle_user" {
  description = "Usuario de Kaggle para autenticación"
  type        = string
}

variable "kaggle_key" {
  description = "API key de Kaggle para autenticación"
  type        = string
  sensitive   = true
}
