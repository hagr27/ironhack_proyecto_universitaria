output "db_instance_name" {
  value = google_sql_database_instance.db_instance.name
}

output "db_connection_name" {
  value = google_sql_database_instance.db_instance.connection_name
}

output "db_public_ip" {
  value = google_sql_database_instance.db_instance.public_ip_address
}

output "db_name" {
  value = google_sql_database.db.name
}

output "db_users" {
  value = [
    google_sql_user.admin_user.name,
    google_sql_user.user1.name,
    google_sql_user.user2.name
  ]
}