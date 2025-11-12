variable "project_id" {}
variable "region" {
  default = "europe-west3"
}
variable "bucket_name" {}
variable "function_name" {}
variable "runtime" {
  default = "python311"
}
variable "entry_point" {
  default = "download_kaggle_to_gcs"
}
variable "source_dir" {}
variable "kaggle_user" {}
variable "kaggle_key" {}
