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

import 'dart:convert';

import 'package:dtt_runtime/cloudevents.dart';
import 'package:firebase_auth_example/src/handlers/on_user_created.dart';
import 'package:google_cloud_events/google/events/firebase/auth/v1/data.pb.dart';
import 'package:google_cloud_shelf/google_cloud_shelf.dart';
import 'package:shelf/shelf.dart';

void main() async {
  // 1. Initialize the vertical Eventarc routing engine
  final router = DttEventRouter()
    ..register<AuthEventData>(
      path: '/events/auth',
      eventType: 'google.firebase.auth.user.v1.created',
      dataParser: (bytes, contentType) {
        final isJson = contentType != null && contentType.contains('json');
        if (isJson) {
          final jsonMap =
              jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
          return AuthEventData()..mergeFromProto3Json(jsonMap);
        } else {
          return AuthEventData.fromBuffer(bytes);
        }
      },
      handler: onUserCreated,
    );

  // 2. Wrap router handler in shelf logging/trace middleware pipeline
  final pipeline = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.handle);

  // 3. Delegate production serving to package:google_cloud_shelf
  // This automatically resolves system PORT, setups structured JSON logs,
  // correlates metadata traces, and catches SIGTERM sockets gracefully.
  await serveHandler(pipeline);
}
