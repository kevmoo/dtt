terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google      = {
    source = "hashicorp/google"
    version = ">= 5.0.0"
  }
    google-beta = {
    source = "hashicorp/google-beta"
    version = ">= 5.0.0"
  }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Retrieve live metadata of our pre-deployed OS-only service
data "google_cloud_run_v2_service" "service" {
  name       = "gcs-triggers"
  location   = var.region
  depends_on = [ null_resource.cloud_run_deploy ]
}

# Retrieve live project metadata for Service Agent referencing
data "google_project" "project" {
}

# E2E Source-Based deployment compiler utilizing Dart helper script preventing local codebase pollution and ensuring Windows/POSIX support
resource "null_resource" "cloud_run_deploy" {
  triggers = {
    config_hash = fileexists("${path.module}/../dtt.yaml") ? filesha256("${path.module}/../dtt.yaml") : "default"
    server_hash = fileexists("${path.module}/../bin/server.dart") ? filesha256("${path.module}/../bin/server.dart") : "default"
    deploy_hash = fileexists("${path.module}/../bin/deploy.dart") ? filesha256("${path.module}/../bin/deploy.dart") : "default"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../examples/firebase_auth_example"
    command     = "dart run bin/deploy.dart /Users/kevmoo/.local/share/google-cloud-sdk/bin/gcloud gcs-triggers ${var.project_id} ${var.region}"
  }
}

# Zero-Trust minimum privilege service account mapping
resource "google_service_account" "eventarc_invoker" {
  account_id   = "dtt-gcs-triggers-inv"
  display_name = "Eventarc gcs-triggers Invoker Service Account"
}

# Grant Invoker Service Account authorization to call our Cloud Run container
resource "google_cloud_run_v2_service_iam_member" "invoker_role" {
  name     = data.google_cloud_run_v2_service.service.name
  location = data.google_cloud_run_v2_service.service.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.eventarc_invoker.email}"
}

# Bind Eventarc Receiver permissions to standard GCP service agent profiles
resource "google_project_iam_member" "eventarc_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.eventarc_invoker.email}"
}

data "google_storage_project_service_account" "gcs_account" {
}

# Grant Cloud Storage Service Agent permissions to publish to transport topics
resource "google_project_iam_member" "storage_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

# Grant Pub/Sub Service Agent permissions to generate OIDC tokens under our Custom SA
resource "google_service_account_iam_member" "pubsub_token_creator" {
  service_account_id = google_service_account.eventarc_invoker.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

# Grant Eventarc Service Agent permissions to act as our Custom SA
resource "google_service_account_iam_member" "eventarc_sa_user" {
  service_account_id = google_service_account.eventarc_invoker.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-eventarc.iam.gserviceaccount.com"
}

# GCP Eventarc Trigger Mapping signals: on-upload
resource "google_eventarc_trigger" "trigger_on-upload" {
  name            = "gcs-triggers-on-upload-trigger"
  location        = var.region
  service_account = google_service_account.eventarc_invoker.email

  destination {
    cloud_run_service {
      service = data.google_cloud_run_v2_service.service.name
      region  = var.region
      path    = "/events/uploads"
    }
  }

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = "dart-sdk-bazel-sandbox-dtt-upload"
  }
}
