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
