variable "project_id" {
  type        = string
  description = "Target Google Cloud Platform Project ID."
  default     = "dtt-pkg-test"
}

variable "region" {
  type        = string
  description = "Target GCP region for resources deployment."
  default     = "us-central1"
}

variable "container_image" {
  type        = string
  description = "Target Docker/Artifact Registry container image URL or digest."
}

variable "gcloud_path" {
  type        = string
  description = "Executable path or command name for the Google Cloud SDK CLI."
  default     = "gcloud"
}
