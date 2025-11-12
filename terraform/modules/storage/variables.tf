variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de los buckets"
  type        = string
  default     = "us-central1"
}

variable "users" {
  description = "Lista de correos de usuarios que tendrán acceso a Bronze y Silver"
  type        = list(string)
  default     = []
}
