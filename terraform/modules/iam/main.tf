resource "google_service_account" "vm_sa" {
  account_id   = "ml-vm-sa"
  display_name = "Service account for ML VM"
}

# Bronze users - lectura y escritura
resource "google_storage_bucket_iam_member" "bronze_users" {
  for_each = toset(var.users)
  bucket   = var.bronze_bucket
  role     = "roles/storage.objectAdmin"
  member   = "user:${each.value}"
}

# Silver users - lectura y escritura
resource "google_storage_bucket_iam_member" "silver_users" {
  for_each = toset(var.users)
  bucket   = var.silver_bucket
  role     = "roles/storage.objectAdmin"
  member   = "user:${each.value}"
}

# Gold users - solo lectura
resource "google_storage_bucket_iam_member" "gold_users" {
  for_each = toset(var.users)
  bucket   = var.gold_bucket
  role     = "roles/storage.objectViewer"
  member   = "user:${each.value}"
}

# Notebook users - lectura y escritura
resource "google_storage_bucket_iam_member" "notebook_users" {
  for_each = toset(var.users)
  bucket   = var.notebook_bucket
  role     = "roles/storage.objectAdmin"
  member   = "user:${each.value}"
}

