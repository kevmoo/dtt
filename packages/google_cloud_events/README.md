Pre-compiled, type-safe Dart Protobuf classes representing canonical Google
Cloud Platform (GCP) and Firebase Eventarc payload definitions.

---

## 📦 Supported Event Catalog

Below is the canonical list of Eventarc triggers supported by this package and
their associated schema metadata:

<!-- CATALOG_TABLE_START -->
| Eventarc Event Type | Protobuf Payload Class | Default Path |
| :--- | :--- | :--- |
| `google.cloud.firestore.document.v1.created` | `Struct` | `/events/firestore/created` |
| `google.cloud.firestore.document.v1.deleted` | `Struct` | `/events/firestore/deleted` |
| `google.cloud.firestore.document.v1.updated` | `Struct` | `/events/firestore/updated` |
| `google.cloud.firestore.document.v1.written` | `Struct` | `/events/firestore` |
| `google.cloud.pubsub.topic.v1.messagePublished` | `MessagePublishedData` | `/events/pubsub` |
| `google.cloud.storage.object.v1.archived` | `StorageObjectData` | `/events/uploads/archived` |
| `google.cloud.storage.object.v1.deleted` | `StorageObjectData` | `/events/uploads/deleted` |
| `google.cloud.storage.object.v1.finalized` | `StorageObjectData` | `/events/uploads` |
| `google.cloud.storage.object.v1.metadataUpdated` | `StorageObjectData` | `/events/uploads/metadata` |
| `google.firebase.auth.user.v2.created` | `AuthEventData` | `/events/auth` |
| `google.firebase.auth.user.v2.deleted` | `AuthEventData` | `/events/auth/deleted` |
| `google.firebase.firebasealerts.alerts.v1.published` | `AlertData` | `/events/alerts` |
| `google.firebase.remoteconfig.v1.updated` | `RemoteConfigEventData` | `/events/remoteconfig` |
<!-- CATALOG_TABLE_END -->

---

## 🏗️ Re-compiling Schemas

This package is automatically maintained by our catalog generation engine. To
add new Eventarc triggers or sync upstream Protobuf models, refer to the
monorepo [tooling guide](../../tool/README.md).
