##############################################
# CONFIGURACIÓN DEL PROVEEDOR GOOGLE CLOUD
##############################################
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

##############################################
# MÓDULO CLOUD SQL (PostgreSQL)
##############################################
module "cloudsql" {
  source = "./modules/cloudsql"

  project_id       = var.project_id
  region           = var.region
  db_instance_name = var.db_instance_name
  db_name          = var.db_name

  db_user      = var.db_user
  db_password  = var.db_password
  db_user1     = var.db_user1
  db_password1 = var.db_password1
  db_user2     = var.db_user2
  db_password2 = var.db_password2

  credentials_file = var.credentials_file
}

##############################################
# MÓDULO CLOUD STORAGE
##############################################
module "storage" {  
  source     = "./modules/storage"
  project_id = var.project_id
  region     = var.region
  users      = ["alejandro.grna@gmail.com", "margarethpino24@gmail.com"]
}

##############################################
# MÓDULO CLOUD FUNCTIONS - download_kaggle_to_gcs
##############################################
module "elt_function" {
  source        = "./modules/compute/cloud_function"
  project_id    = var.project_id
  region        = var.region
  bucket_name   = module.storage.bucket_bronze
  function_name = "download_kaggle_to_gcs"
  source_dir    = "../elt_kaggle_function"
  kaggle_user   = var.kaggle_user
  kaggle_key    = var.kaggle_key
}
