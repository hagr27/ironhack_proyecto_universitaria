output "bronze_bucket_users" {
  value = [for u in values(google_storage_bucket_iam_member.bronze_users) : u.member]
}

output "silver_bucket_users" {
  value = [for u in values(google_storage_bucket_iam_member.silver_users) : u.member]
}

output "gold_bucket_users" {
  value = [for u in values(google_storage_bucket_iam_member.gold_users) : u.member]
}

output "notebook_bucket_users" {
  value = [for u in values(google_storage_bucket_iam_member.notebook_users) : u.member]
}
