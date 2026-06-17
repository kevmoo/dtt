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

import 'package:dtt_runtime/cloudevents.dart';
import 'package:google_cloud_events/google_cloud_events.dart';
import 'package:google_cloud_shelf/google_cloud_shelf.dart';

/// Strongly-typed callback handler intercepting Google Cloud Storage object
/// upload finalization signals in real-time.
Future<void> onUpload(CloudEvent<StorageObjectData> event) async {
  currentLogger.info(
    '📡 RECEIVED REAL-TIME GCS OBJECT UPLOAD FINALIZATION SIGNAL!',
    payload: {
      'eventId': event.id,
      'eventType': event.type,
      'eventSource': event.source.toString(),
      'eventSubject': event.subject,
      'objectData': event.data.toProto3Json(),
    },
  );
}
