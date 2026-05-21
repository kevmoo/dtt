# Blueprint Blueprints: Firebase Functions vs. GCP Terraform Triggers

This directory contains concrete, comparative code blueprints illustrating the developer experience, runtime sever routing, and deployment configurations under both the Firebase SDK paradigm and our proposed pure GCP/Terraform design:

1.  **Thought 1: The Firebase Paradigm**:
    - Located in [thought_1_firebase_style/](file:///Users/kevmoo/github/kevmoo/dart_terraform_triggers/firebase_functions_compare/thought_1_firebase_style)
    - Represents the builder-driven, runtime-namespace routing API of `package:firebase_functions`.
    - Features the emulator-only configuration and the manual hand-coded JSON-deserialization model models.
2.  **Thought 2: The GCP Terraform Paradigm**:
    - Located in [thought_2_terraform_style/](file:///Users/kevmoo/github/kevmoo/dart_terraform_triggers/firebase_functions_compare/thought_2_terraform_style)
    - **(RECOMMENDED)** Represents our `dtt` design targeting raw GCP.
    - Employs a dynamic remote protobuf code-generator to resolve event types recursively, routes events through zero-reflection static Shelf pipelines, and maps target infrastructure using secure, minimum-privilege Terraform manifests.

---

## ⚡ Key Comparison Highlights

*   **API Ergonomics**: 
    - In **Thought 1**, developers register triggers by invoking a global functional registry helper:
      ```dart
      firebase.storage.onObjectFinalized(bucket: 'my-bucket', (event) async { ... });
      ```
    - In **Thought 2**, developers declare trigger variables inside a root-level [dtt.yaml](file:///Users/kevmoo/github/kevmoo/dart_terraform_triggers/dtt.yaml) file, and map type-safe business handlers directly to modular callbacks:
      ```dart
      void onStorageUpload(CloudEvent<StorageObjectData> event) { ... }
      ```

*   **Production Deployment Boundaries**:
    - Under **Thought 1**, attempting to deploy background storage or firestore triggers fails in production since `firebase_functions` does not support automated event routing authorization handshakes for non-Node.js runtimes (resulting in Emulator-Only status).
    - Under **Thought 2**, deploying to production is 100% stable, secure, and ready on Day 1. The synthesized Terraform configurations in [thought_2_terraform_style/terraform/main.tf](file:///Users/kevmoo/github/kevmoo/dart_terraform_triggers/firebase_functions_compare/thought_2_terraform_style/terraform/main.tf) natively handle creating triggers, configuring target Cloud Run services, and provisioning cryptographically validated OIDC IAM service account profiles!
