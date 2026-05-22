terraform {
  required_version = ">= 1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Google Cloud Run v2 Service running our serverless Dart binary
resource "google_cloud_run_v2_service" "service" {
  name     = "firebase-auth-triggers"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY" # Security boundary (prevents public HTTP spoofing!)

  template {
    containers {
      image = "us-central1-docker.pkg.dev/${var.project_id}/cloud-run-images/firebase-auth-triggers:latest"
      
      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

# 2. Zero-Trust minimum privilege service account mapping
resource "google_service_account" "eventarc_invoker" {
  account_id   = "eventarc-firebase-auth-triggers-invoker"
  display_name = "Eventarc firebase-auth-triggers Invoker Service Account"
}

# 3. Grant Invoker Service Account authorization to call our Cloud Run container
resource "google_cloud_run_v2_service_iam_member" "invoker_role" {
  name     = google_cloud_run_v2_service.service.name
  location = google_cloud_run_v2_service.service.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.eventarc_invoker.email}"
}

# 4. Bind Eventarc Receiver permissions to standard GCP service agent profiles
resource "google_project_iam_member" "eventarc_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.eventarc_invoker.email}"
}
# 5. GCP Eventarc Trigger Mapping signals: auth-user-created
resource "google_eventarc_trigger" "trigger_auth-user-created" {
  name     = "firebase-auth-triggers-auth-user-created-trigger"
  location = var.region

  destination {
    cloud_run_service {
      service = google_cloud_run_v2_service.service.name
      region  = var.region
      path    = "/events/auth"
    }
  }

  matching_criteria {
    attribute = "type"
    value     = "google.firebase.auth.user.v1.created"
  }

  service_account = google_service_account.eventarc_invoker.email
}
