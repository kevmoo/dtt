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

import 'dart:async';

import 'package:dtt_runtime/cloudevents.dart';
import 'package:google_cloud_events/google/events/firebase/auth/v1/data.pb.dart';
import 'package:google_cloud_logging/google_cloud_logging.dart';

const _logger = CloudLogger.structuredLogger();

/// Developer callback handler triggered whenever a new Firebase Auth user
/// account is created.
FutureOr<void> onUserCreated(CloudEvent<AuthEventData> event) {
  final user = event.data;
  final metadata = user.metadata;

  // Format creation timestamp natively using Timestamp's standard DateTime
  // conversion
  final createdUtc = metadata.hasCreateTime()
      ? metadata.createTime.toDateTime().toUtc().toIso8601String()
      : 'N/A';

  // Construct a beautiful structured logging payload map!
  final payload = <String, Object?>{
    'eventId': event.id,
    'eventSource': event.source.toString(),
    'uid': user.uid,
    'email': user.email.isNotEmpty ? user.email : null,
    'displayName': user.displayName.isNotEmpty ? user.displayName : null,
    'createdAt': createdUtc,
    'disabled': user.disabled,
  };

  if (user.providerData.isNotEmpty) {
    payload['providers'] = user.providerData
        .map((p) => {'providerId': p.providerId, 'uid': p.uid})
        .toList();
  }

  // Emit a single high-fidelity structured log entry mapped to GCP Logging
  _logger.info(
    'Firebase Auth user account created successfully for UID: ${user.uid}',
    payload: payload,
  );
}
