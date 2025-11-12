##############################################
# BUCKET TEMPORAL PARA EL CÓDIGO
##############################################
resource "google_storage_bucket" "function_source" {
  name          = "${var.project_id}-function-source"
  location      = var.region
  force_destroy = true # Esto permite borrar el bucket aunque tenga objetos
}

# Subida del zip de la función
resource "google_storage_bucket_object" "function_zip" {
  name   = "${var.function_name}.zip"
  bucket = google_storage_bucket.function_source.name
  source = "${var.source_dir}/function.zip"
}

##############################################
# CREACIÓN DE LA CLOUD FUNCTION
##############################################
resource "google_cloudfunctions_function" "function" {
  name        = var.function_name
  project     = var.project_id
  region      = var.region
  runtime     = var.runtime
  entry_point = var.entry_point

  source_archive_bucket = google_storage_bucket.function_source.name
  source_archive_object = google_storage_bucket_object.function_zip.name

  trigger_http        = true
  available_memory_mb = 512
  timeout             = 300

  # Variables de entorno
  environment_variables = {
    KAGGLE_USER = var.kaggle_user
    KAGGLE_KEY  = var.kaggle_key
    BUCKET_NAME = var.bucket_name
  }
}

##############################################
# PERMITIR EJECUCIÓN PÚBLICA DE LA FUNCIÓN
##############################################
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}
