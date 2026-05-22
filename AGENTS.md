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

## 📋 The Step-by-Step E2E Milestones

We will tackle this vertical path in four structured, lean milestones:

### Milestone 1: Implement the Unified CloudEvent Envelope Parser (`dtt_runtime`)
*   **Action**: Write the core parser in `packages/dtt_runtime/lib/cloudevents.dart`.
*   **Scope**:
    *   Define the generic `CloudEvent<T>` mapping envelope structure.
    *   Implement binary header check: resolve metadata sent in HTTP headers (e.g., `ce-type`, `ce-source`, `ce-id`) and read raw bytes from request stream.
    *   Implement structured JSON check: decode request payload as JSON and unpack properties out of standard envelopes.
    *   Integrate Shelf pipeline integrations to pass typed events cleanly to developers callbacks.

### Milestone 2: Mount Target Event Models (`google_cloud_events`)
*   **Action**: Compile and package only the GCS payload structures.
*   **Scope**:
    *   Download standard GCS proto specs (`google/events/cloud/storage/v1/data.proto`) and its direct dependencies.
    *   Invoke `protoc` and compile `StorageObjectData` model definitions into `packages/google_cloud_events`.
    *   Expose standard imports so it's ready to be depended upon by our runtime pipelines.

### Milestone 3: Develop the CLI Scaffold Generator (`dtt`)
*   **Action**: Program the code-generator mapping configuration inputs.
*   **Scope**:
    *   Read local `dtt.yaml` declaring the GCS trigger.
    *   Synthesize standard `bin/server.dart` entrypoint. This server will use **`package:google_cloud_shelf`** under the hood (instantly gaining structured JSON logs, trace correlations, and SIGTERM terminate signals gracefully) and mount the `dtt_runtime` middleware mapped to `/events/uploads`.
    *   Stub out the type-safe developer handler inside `lib/src/handlers/on_upload.dart` receiving `CloudEvent<StorageObjectData>`.
    *   Generate secure, minimal-privilege Terraform manifests (`main.tf`, `variables.tf`, `outputs.tf`) mapping trigger resources and run invokers.

### Milestone 4: Hermetic E2E Webhook Validation Test
*   **Action**: Verify the complete vertical flow using robust integration testing under the root `test/` workspace.
*   **Scope**:
    *   Construct an isolated test runner matching the target developer workflow.
    *   Programmatically generate the mock templates under a temporary directory using `package:test_descriptor`.
    *   Spin up the auto-generated static server locally on the workstation.
    *   Simulate mock GCP Eventarc pushes using `package:http` (spamming both binary header request envelopes and structured JSON request bodies).
    *   Assert that the server successfully deserializes the payloads, verifies types, correlates logs, and triggers the callback handler with 100% correct attributes.

---

## 🗺️ Execution Strategy

By adopting this lean sequence, **we can get the full E2E vertical integration working locally in a single, focused session**, proving the complete runtime, code-generation, and infrastructure architectures under a pristine testing validation. Once this is solid, we can begin filling in the remaining tooling commands, deployments CLI boundaries, and catalog mappings.
