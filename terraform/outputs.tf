##############################################
# SALIDAS DEL MÓDULO CLOUD SQL
##############################################

output "cloudsql_instance_name" {
  description = "Nombre de la instancia de Cloud SQL"
  value       = module.cloudsql.db_instance_name
}

output "cloudsql_public_ip" {
  description = "Dirección IP pública de la instancia de Cloud SQL"
  value       = module.cloudsql.db_public_ip
}

output "cloudsql_connection_name" {
  description = "Nombre de conexión de la instancia Cloud SQL (para DBeaver o apps)"
  value       = module.cloudsql.db_connection_name
}

output "cloudsql_database_name" {
  description = "Nombre de la base de datos principal"
  value       = module.cloudsql.db_name
}

output "cloudsql_users" {
  description = "Usuarios creados en la base de datos"
  value       = module.cloudsql.db_users
}

##############################################
# SALIDAS DEL MÓDULO CLOUD STORAGE
##############################################

output "bronze_bucket" {
  description = "Bucket Bronze"
  value       = module.storage.bucket_bronze
}

output "silver_bucket" {
  description = "Bucket Silver"
  value       = module.storage.bucket_silver
}

output "gold_bucket" {
  description = "Bucket Gold"
  value       = module.storage.bucket_gold
}
