# GCS Storage Eventarc Example

This example demonstrates how to build, test locally, and deploy a serverless Dart microservice responding to Google Cloud Storage finalization events (`google.cloud.storage.object.v1.finalized`).

## 📁 Project Structure

- `dtt.yaml`: Declarative service configuration, security profile, and trigger definitions.
- `lib/src/handlers/on_upload.dart`: Strongly-typed CloudEvent callback handler.
- `bin/server.dart`: Generated Shelf entrypoint server.

## 🚀 Local Development & Deployment Walkthrough

1. **Boot local server and simulate CloudEvent**:
   ```bash
   dtt dev --emit-event=google.cloud.storage.object.v1.finalized \
           --payload='{"bucket":"dtt-test-bucket","name":"sample.txt"}'
   ```

2. **Build container image**:
   ```bash
   dtt build
   ```

3. **Deploy infrastructure via Terraform**:
   ```bash
   dtt deploy
   ```
