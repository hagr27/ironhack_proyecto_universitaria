# Bronze bucket
resource "google_storage_bucket" "bronze" {
  name          = "${var.project_id}-bronze"
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action { type = "Delete" }
    condition { age = 30 }
  }
}

# Silver bucket
resource "google_storage_bucket" "silver" {
  name          = "${var.project_id}-silver"
  location      = var.region
  force_destroy = true

  versioning { enabled = true }

  lifecycle_rule {
    action { type = "Delete" }
    condition { age = 30 }
  }
}

# Gold bucket
resource "google_storage_bucket" "gold" {
  name          = "${var.project_id}-gold"
  location      = var.region
  force_destroy = true

  versioning { enabled = true }

  lifecycle_rule {
    action { type = "Delete" }
    condition { age = 60 }
  }
}

# IAM para usuarios que puedan acceder y modificar Bronze
resource "google_storage_bucket_iam_member" "bronze_users" {
  for_each = toset(var.users)
  bucket   = google_storage_bucket.bronze.name
  role     = "roles/storage.objectAdmin"  # lectura + escritura
  member   = "user:${each.value}"
}

# IAM para usuarios que puedan acceder y modificar Silver
resource "google_storage_bucket_iam_member" "silver_users" {
  for_each = toset(var.users)
  bucket   = google_storage_bucket.silver.name
  role     = "roles/storage.objectAdmin"  # lectura + escritura
  member   = "user:${each.value}"
}

# IAM para usuarios que puedan acceder a Gold (solo lectura)
resource "google_storage_bucket_iam_member" "gold_users" {
  for_each = toset(var.users)
  bucket   = google_storage_bucket.gold.name
  role     = "roles/storage.objectViewer"  # solo lectura
  member   = "user:${each.value}"
}
