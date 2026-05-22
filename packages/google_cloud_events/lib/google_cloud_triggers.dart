// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:protobuf/protobuf.dart';
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart';

import 'google/events/cloud/storage/v1/data.pb.dart';
import 'google/events/firebase/auth/v1/data.pb.dart';

/// Centralized, strongly-typed Enum catalog resolving GCP and Firebase
/// triggers.
/// Conforms to official Eventarc and CloudEvents specifications.
enum CloudEventTrigger<T extends GeneratedMessage> {
  /// Triggered when a document is written in Cloud Firestore.
  firestoreDocumentWritten<Struct>(
    eventType: 'google.cloud.firestore.document.v1.written',
    defaultPath: '/events/firestore',
    create: Struct.create,
  ),

  /// Triggered when a new user is created in Firebase Authentication.
  firebaseAuthUserCreated<AuthEventData>(
    eventType: 'google.firebase.auth.user.v2.created',
    defaultPath: '/events/auth',
    create: AuthEventData.create,
  ),

  /// Triggered when an existing user is deleted in Firebase Authentication.
  firebaseAuthUserDeleted<AuthEventData>(
    eventType: 'google.firebase.auth.user.v2.deleted',
    defaultPath: '/events/auth/deleted',
    create: AuthEventData.create,
  ),

  /// Triggered when an object is uploaded/finalized in Google Cloud Storage.
  gcsObjectFinalized<StorageObjectData>(
    eventType: 'google.cloud.storage.object.v1.finalized',
    defaultPath: '/events/uploads',
    create: StorageObjectData.create,
  );

  /// Unique Eventarc GCP/Firebase trigger event type.
  final String eventType;

  /// Default HTTP webhook request endpoint path route.
  final String defaultPath;

  /// Target Protobuf constructor factory template creator.
  final T Function() create;

  const CloudEventTrigger({
    required this.eventType,
    required this.defaultPath,
    required this.create,
  });
}
