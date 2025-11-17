variable "users" {
  description = "Lista de usuarios a los que se les asignarán permisos"
  type        = list(string)
}

variable "bronze_bucket" {
  description = "Nombre del bucket Bronze"
  type        = string
}

variable "silver_bucket" {
  description = "Nombre del bucket Silver"
  type        = string
}

variable "gold_bucket" {
  description = "Nombre del bucket Gold"
  type        = string
}

variable "notebook_bucket" {
  description = "Nombre del bucket para notebooks"
  type        = string
}
