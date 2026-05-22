variable "project_id" {
  type        = string
  description = "Target Google Cloud Platform Project ID."
  default     = "n26-full-stack-dart"
}

variable "region" {
  type        = string
  description = "Target GCP region for resources deployment."
  default     = "us-central1"
}
