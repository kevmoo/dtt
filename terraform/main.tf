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
  name       = "firestore-triggers"
  location   = var.region
  depends_on = [ null_resource.cloud_run_deploy ]
}

# Retrieve live project metadata for Service Agent referencing
data "google_project" "project" {
}

# E2E Source-Based deployment compiler utilizing Google Buildpacks preventing local codebase pollution
resource "null_resource" "cloud_run_deploy" {
  triggers = {
    config_hash = fileexists("${path.module}/../dtt.yaml") ? filesha256("${path.module}/../dtt.yaml") : "default"
    server_hash = fileexists("${path.module}/../bin/server.dart") ? filesha256("${path.module}/../bin/server.dart") : "default"
  }

  provisioner "local-exec" {
    command = <<EOT
      # 1. Create a clean, isolated temporary staging directory inside system /tmp!
      STAGE_DIR=$(mktemp -d -t dtt-build-XXXXXX)
      echo "📡 Created isolated temporary staging directory: $STAGE_DIR"

      # 2. Structure the clean target folders
      mkdir -p $STAGE_DIR/bin

      # 3. Cross-compile the Dart server to a standalone native Linux AOT ELF binary!
      cd ${path.module}/../examples/firebase_auth_example
      dart pub get
      dart compile exe bin/server.dart \
        -o $STAGE_DIR/bin/server \
        --target-os linux \
        --target-arch x64

      # 4. Deploy the compiled temp directory directly to Cloud Run using osonly base image!
      /Users/kevmoo/.local/share/mise/installs/gcloud/569.0.0/bin/gcloud beta run deploy firestore-triggers \
        --source=$STAGE_DIR \
        --region=${var.region} \
        --ingress=all \
        --allow-unauthenticated \
        --project=${var.project_id} \
        --no-build \
        --base-image=osonly24 \
        --command=bin/server \
        --quiet

      # 5. Clean up the temporary staging directory cleanly!
      rm -rf $STAGE_DIR

EOT
  }
}

# Zero-Trust minimum privilege service account mapping
resource "google_service_account" "eventarc_invoker" {
  account_id   = "dtt-firestore-trigg-inv"
  display_name = "Eventarc firestore-triggers Invoker Service Account"
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

# Grant Cloud Firestore Service Agent permissions to publish to transport topics
resource "google_project_iam_member" "firestore_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-firestore.iam.gserviceaccount.com"
}

# Enable Project-Wide Data Access Audit Logs for all services to forward triggers event signals
resource "google_project_iam_audit_config" "all_services_audit" {
  project = var.project_id
  service = "allServices"

  audit_log_config {
    log_type = "DATA_WRITE"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }
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

# GCP Eventarc Trigger Mapping signals: user-written
resource "google_eventarc_trigger" "trigger_user-written" {
  name                    = "firestore-triggers-user-written-trigger"
  location                = "nam5"
  event_data_content_type = "application/protobuf"
  service_account         = google_service_account.eventarc_invoker.email

  destination {
    cloud_run_service {
      service = data.google_cloud_run_v2_service.service.name
      region  = var.region
      path    = "/events/users"
    }
  }

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.firestore.document.v1.written"
  }

  matching_criteria {
    attribute = "database"
    value     = "(default)"
  }

  matching_criteria {
    attribute = "document"
    value     = "documents/users/{userId}"
  }
}
