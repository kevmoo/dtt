# terraform/main.tf
# PRODUCTION READY TRIGGER PROVISIONING - BYPASSES EMULATOR-ONLY BARRIERS

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Dedicated, minimum-privilege Service Account for Eventarc Push handshakes
resource "google_service_account" "eventarc_push_agent" {
  account_id   = "${var.service_name}-push-sa"
  display_name = "Eventarc Push Identity invoking ${var.service_name}"
}

# 2. Cryptographic authorization binding: Grant the SA permission to invoke Cloud Run
# GCP's GFE front-end router automatically verifies this OIDC signature
resource "google_cloud_run_v2_service_iam_member" "run_invoker_binding" {
  location = google_cloud_run_v2_service.gcp_service.location
  name     = google_cloud_run_v2_service.gcp_service.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.eventarc_push_agent.email}"
}

# 3. Secure Serverless Cloud Run container running our Dart AOT microservice
resource "google_cloud_run_v2_service" "gcp_service" {
  name     = var.service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY" # Closed boundary blocking public network calls!

  template {
    containers {
      image = var.container_image
      ports {
        container_port = 8080
      }
      resources {
        limits = {
          cpu    = "1"
          memory = "256Mi" # Super-lean size enabled by static Shelf micro-engine!
        }
      }
    }
  }
}

# 4. Standard Eventarc Background Trigger matching GCS Bucket finalizations in Production GCP!
# This resources maps events, connects agents, authorizes identities, and routes webhooks natively.
resource "google_eventarc_trigger" "gcs_finalized_trigger" {
  name     = "gcs-upload-trigger"
  location = var.region

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = var.gcs_bucket_name
  }

  destination {
    cloud_run {
      service = google_cloud_run_v2_service.gcp_service.name
      region  = google_cloud_run_v2_service.gcp_service.location
      path    = "/events/storage"
    }
  }

  service_account = google_service_account.eventarc_push_agent.email

  depends_on = [
    google_cloud_run_v2_service_iam_member.run_invoker_binding
  ]
}
