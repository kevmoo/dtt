# Dart Terraform Triggers CLI (`dtt`)

Command-line tool for scaffolding, generating type-safe routers, simulating CloudEvents locally, building container images, and deploying Terraform infrastructure for Dart serverless microservices on Google Cloud Platform.

## 📦 Installation

```bash
dart pub global activate dtt
```

## 🛠️ CLI Command Reference

### `dtt init`
Initializes a new microservice workspace and `dtt.yaml` manifest.
- `-s, --service-name`: Cloud Run service name (default: `dtt-service`).
- `-p, --project-id`: Target GCP Project ID.
- `-r, --region`: Target GCP deployment region (default: `us-central1`).

### `dtt trigger add`
Interactively or declaratively registers an Eventarc trigger mapping.
- `-t, --type`: Trigger type identifier (e.g. `google.cloud.storage.object.v1.finalized`).
- `-s, --handler`: Target handler function name.
- `-p, --path`: Target HTTP endpoint path (defaults to `/events`).
- `-r, --resource`: GCP resource filter path (e.g. `projects/_/buckets/my-bucket`).

### `dtt generate`
Generates Shelf event router entrypoints (`bin/server.dart`) and declarative Terraform HCL manifests (`terraform/main.tf`).
- `-p, --package-dir`: Target package folder path (defaults to current directory).

### `dtt dev`
Boots local development Shelf server or emits simulated CloudEvents.
- `--port`: Local HTTP server port (default: `8080`).
- `--emit-event`: CloudEvent type string to simulate locally.
- `--payload`: Path to JSON fixture file or inline JSON string data.
- `--path`: Target HTTP endpoint path (default: `/events/uploads`).

### `dtt build`
Compiles Dart AOT binary, packages Docker container, creates Artifact Registry repository (`dtt-repository`), and records image digest in `.dtt/build_state.json`.
- `-p, --package-dir`: Target package directory (default: `.`).
- `-t, --tag`: Custom image tag (defaults to timestamp).

### `dtt deploy`
Provisions GCP infrastructure via Terraform `apply` using pre-built container digest.
- `-p, --package-dir`: Target package directory (default: `.`).
- `-i, --image`: Custom container image URL/digest (bypasses `.dtt/build_state.json`).
- `-b, --build`: Triggers `dtt build` prior to deployment if image is omitted (default: `true`).
