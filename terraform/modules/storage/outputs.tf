output "bucket_bronze" {
  description = "Bucket Bronze"
  value       = google_storage_bucket.bronze.name
}

output "bucket_silver" {
  description = "Bucket Silver"
  value       = google_storage_bucket.silver.name
}

output "bucket_gold" {
  description = "Bucket Gold"
  value       = google_storage_bucket.gold.name
}
