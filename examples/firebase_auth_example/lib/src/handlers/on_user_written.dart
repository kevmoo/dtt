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
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart';

/// Strongly-typed callback handler intercepting Cloud Firestore document write
/// transaction signals in real-time.
Future<void> onUserWritten(CloudEvent<Struct> event) async {
  print('================================================================');
  print('📡 RECEIVED REAL-TIME CLOUD FIRESTORE DOCUMENT WRITE SIGNAL! 📡');
  print('================================================================');
  print('Trigger Event ID : ${event.id}');
  print('Event Type       : ${event.type}');
  print('Database Context : ${event.source}');

  // Under CloudEvents Firestore specifications, event.subject maps the
  // dynamic resource document path (e.g. "documents/users/userId")!
  print('Document Target  : ${event.subject}');

  print('Snapshots Data   :');
  final fields = event.data.fields;
  for (final entry in fields.entries) {
    print('  - ${entry.key}: ${entry.value}');
  }
  print('================================================================');
}
