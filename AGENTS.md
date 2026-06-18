# Vertical Implementation Plan: Minimal End-to-End (E2E) Path

This document outlines our lean, focused roadmap to complete the absolute **minimal, vertical end-to-end integration flow** for `dart_terraform_triggers` (`dtt`). 

To prevent directory noise and accelerate delivery loops, we bypass broad packaging and catalog compilations. Instead, we isolate a **single vertical trigger flow** (Google Cloud Storage uploads finalized) and implement the bare minimum runtime routing and CLI scaffolding generators to prove the architecture 100% locally.

---

## 🎯 The Minimal Vertical Target: GCS Trigger
We select the standard **Google Cloud Storage finalization trigger** as our sole E2E payload target:
*   **Trigger Event Type**: `google.cloud.storage.object.v1.finalized`
*   **Protobuf Payload Model**: `StorageObjectData` (compiled from official GCP definitions)
*   **Path Route**: `/events/uploads`

---

## 🏗️ Minimal Components & Scopes

To get this flow working end-to-end, we will implement only these essential blocks:

```
dart_terraform_triggers/
├── packages/
│   ├── dtt_runtime/ (Core serverless Shelf routing & webhook parsers)
│   │   └── lib/cloudevents.dart (Main parsing engine mapping Binary/Structured envelopes)
│   │
│   ├── google_cloud_events/ (Pure, pre-compiled model schemas)
│   │   └── lib/google/events/cloud/storage/v1/data.pb.dart (Exactly compiled GCS models)
│   │
│   └── dtt/ (CLI generator & orchestrator)
│       └── lib/src/codegen/ (Generator engine reading dtt.yaml and outputting servers & SAs)
│
└── _integration_test/ (Hermetic test package suite verifying routing)
    ├── pubspec.yaml (Isolated package configuration mapping test frameworks)
    └── test/e2e_webhook_test.dart (Three integration tests verifying webhooks)
```

---

## 🛠️ Development & Tooling Guidelines

### Running Integration Tests
* Always run integration tests before declaring work complete:
  ```bash
  cd _integration_test && dart test
  ```

### Updating Event Catalog & Schemas
When adding new Eventarc triggers or updating upstream Protobuf definitions, run the maintainer scripts from the monorepo root:
1. **Sync Protos (Stage 1):** `dart run tool/sync_protos.dart` (reads `catalog/protobuf_source.yaml`).
2. **Generate Catalog (Stage 2):** `dart run tool/generate_catalog.dart` (reads `catalog/supported_triggers.txt`).

### Verification
* Run `dart format .` and `dart analyze .` before finalizing changes.
