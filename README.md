# Dart Terraform Triggers (`dtt`)

![Dart Terraform Triggers Project Banner](docs/assets/project_banner.png)

[![CI](https://github.com/kevmoo/dtt/actions/workflows/ci.yml/badge.svg)](https://github.com/kevmoo/dtt/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Dart Version](https://img.shields.io/badge/Dart-3.12%20%2B-blue.svg)](#)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.5%20%2B-purple.svg)](#)

A high-performance, developer-centric toolchain and library designed to make it effortless for Dart developers to deploy serverless (Google) Cloud Run services that respond to Eventarc triggers. 

`dtt` bridges the gap between infrastructure configuration and type-safe application code. It automatically resolves GCP event payload schemas, executes remote protobuf generation, mounts Shelf-based HTTP server routers, and synthesizes production-ready Terraform resources.

---

## 📖 Navigating the Project

Explore the canonical specifications and operational walkthroughs below:

* **[Technical Architecture](docs/architecture.md)**: Deep dive into data
  flows, OIDC authentication, schema resolvers, and custom routing engines.
* **[Security Threat Model](docs/threat_model.md)**: High-fidelity security
  mapping detailing trust boundaries, privileged operations, and lockdowns.
* **[Production Deployment Guide](docs/deployment_guide.md)**: Operational
  guide covering Cloud Run perimeter security, IAM invokers, and verification.
* **[Maintainer Toolchain Guide](tool/README.md)**: Execution sequence and
  architecture for our two-stage offline catalog codegen scripts.

---

## ⚡ The Developer Experience: End-to-End

With `dtt`, configuring, coding, and deploying an event-driven serverless system is compressed into a few clean terminal commands:

### 1. Initialize your Project Workspace
```bash
dtt init --project-id=my-gcp-project --service-name=gcs-uploader
```
This scaffolds a standard Dart microservice equipped with our server structure and establishes the root [dtt.yaml](dtt.yaml) configuration file.

### 2. Register an Eventarc Trigger Interactively
```bash
dtt trigger add --type=google.cloud.storage.object.v1.finalized --handler=onNewUpload
```
Behind the scenes, the CLI:
1. Connects to the GCP Eventarc catalog.
2. Resolves the Event payload schema (`StorageObjectData` protobuf model).
3. Downloads the official `.proto` definitions from the `google-cloudevents` repository.
4. Compiles the schema to type-safe Dart classes under `lib/src/generated/`.
5. Scaffolds a strongly-typed handler function inside `lib/src/handlers/on_new_upload.dart` and wires it to your Shelf event router.

### 3. Implement Type-Safe Business Logic
Open your new handler file and write standard, IDE-autocompleted, type-safe Dart:

```dart
// lib/src/handlers/on_new_upload.dart
import 'package:google_cloudevents/storage_object_data.pb.dart';
import 'package:dart_terraform_triggers/cloudevents.dart';

void onNewUpload(CloudEvent<StorageObjectData> event) {
  final StorageObjectData metadata = event.data;
  
  print('Processing file upload event ID: ${event.id}');
  print('File Bucket: ${metadata.bucket}');
  print('File Name: ${metadata.name}');
  print('File Size: ${metadata.size} bytes');
  print('Content Type: ${metadata.contentType}');
}
```

### 4. Direct Production Deployment
When you are ready to ship to Google Cloud Platform, simply execute:
```bash
dtt deploy
```
The CLI automatically:
1. Builds a micro-sized, statically-linked release Dart AOT binary container (Docker).
2. Pushes your container to Google Artifact Registry.
3. Generates standardized, secure Terraform configurations.
4. Invokes `terraform init` and `terraform apply` to safely provision the Trigger and Cloud Run services with minimum-privilege service account scopes and closed ingress configurations.

### 5. Live Cloud Verification
Once deployed, verify your event routing pipeline immediately using two simple
terminal commands:

#### Trigger the Event (Trivial GCS write)
Pipe any test snippet directly into your Terraform-provisioned bucket:
```bash
echo "Hello live Cloud Run trigger!" | gcloud storage cp - gs://my-bucket/ping.txt
```
*(Finalizing the upload fires `google.cloud.storage.object.v1.finalized` via
Eventarc).*

#### Verify Handler Execution (Cloud Logging)
Read your container's stdout structured log stream in real-time:
```bash
gcloud beta run services logs read gcs-uploader --limit=5
```
You will immediately see your developer callback logging the deserialized event!

---

## 🛠️ System Prerequisites

To run `dtt` on your local workstation, ensure you have installed:
- **Dart SDK**: Version `3.12.0` or higher.
- **Protocol Buffers Compiler (`protoc`)**: Version `3.0` or higher, equipped with the Dart `protoc_plugin` package executable in your system path.
- **Terraform CLI**: Version `1.5` or higher.
- **Google Cloud SDK (`gcloud` CLI)**: Authorized to access target resource management APIs.
- **Docker Daemon**: Active for processing container packaging (optional if delegating directly to GCP Cloud Build).

---

## 🌟 Premium Architecture Highlights

- **Binary & Structured Event Processing**: Seamless support for both Eventarc envelope bindings, parsing either HTTP request headers (Binary Mode) or body parameters (Structured Mode).
- **Zero-Trust Terraform Generation**: Generated Terraform templates follow the strictest GCP guidelines:
  - Default ingress set to `INGRESS_TRAFFIC_INTERNAL_ONLY` to block unauthorized public network scans.
  - Dedicated custom Service Accounts generated for each Eventarc trigger agent.
  - Full OIDC-authenticated pushes ensuring cryptographic request signature validations before event triggers ever enter our handler codes.
- **Statically Compiled Containers**: The containerization pipeline runs custom multi-stage AOT builds, reducing final image footprints and speeding up Cold Starts on Cloud Run down to a fraction of a second.
