variable "project_id" {
  type        = string
  description = "Target Google Cloud Platform Project ID."
  default     = "dart-sdk-bazel-sandbox-265004"
}

variable "region" {
  type        = string
  description = "Target GCP region for resources deployment."
  default     = "us-central1"
}

variable "gcloud_path" {
  type        = string
  description = "Executable path or command name for the Google Cloud SDK CLI."
  default     = "gcloud"
}
