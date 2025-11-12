resource "google_sql_database_instance" "db_instance" {
  name             = var.db_instance_name
  project          = var.project_id
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "public-access"
        value = "0.0.0.0/0" # Permite acceso desde cualquier IP (solo para pruebas)
      }
    }
  }
}

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
  project  = var.project_id
}

# Usuario administrador
resource "google_sql_user" "admin_user" {
  name     = var.db_user
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
  project  = var.project_id
}

# Usuario 1 (read/write)
resource "google_sql_user" "user1" {
  name     = var.db_user1
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password1
  project  = var.project_id
}

# Usuario 2 (read/write)
resource "google_sql_user" "user2" {
  name     = var.db_user2
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password2
  project  = var.project_id
}

resource "null_resource" "create_tables" {
  depends_on = [
    google_sql_database_instance.db_instance,
    google_sql_database.db
  ]

  provisioner "local-exec" {
    command = <<EOT
      PGPASSWORD=${var.db_password} psql \
        -h ${google_sql_database_instance.db_instance.public_ip_address} \
        -U ${var.db_user} \
        -d ${google_sql_database.db.name} \
        -f ./modules/cloudsql/sql/create_tables.sql
    EOT
  }
}
