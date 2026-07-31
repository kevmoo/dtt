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
import 'package:http/http.dart' as http;

/// Helper class to construct and simulate CloudEvents for local handler testing.
class EventSimulator {
  final String targetUrl;
  final http.Client _client;

  EventSimulator({
    this.targetUrl = 'http://localhost:8080',
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// Simulates a CloudEvent HTTP POST request in Binary Content Mode.
  Future<http.Response> sendBinaryEvent({
    required String path,
    required String eventType,
    required String source,
    required Map<String, dynamic> data,
    String? eventId,
  }) async {
    final uri = Uri.parse('$targetUrl$path');
    final id = eventId ?? 'sim-${DateTime.now().millisecondsSinceEpoch}';

    return await _client.post(
      uri,
      headers: {
        'ce-specversion': '1.0',
        'ce-id': id,
        'ce-source': source,
        'ce-type': eventType,
        'ce-time': DateTime.now().toUtc().toIso8601String(),
        'content-type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }

  /// Simulates a CloudEvent HTTP POST request in Structured Content Mode.
  Future<http.Response> sendStructuredEvent({
    required String path,
    required String eventType,
    required String source,
    required Map<String, dynamic> data,
    String? eventId,
  }) async {
    final uri = Uri.parse('$targetUrl$path');
    final id = eventId ?? 'sim-${DateTime.now().millisecondsSinceEpoch}';

    final envelope = {
      'specversion': '1.0',
      'id': id,
      'source': source,
      'type': eventType,
      'time': DateTime.now().toUtc().toIso8601String(),
      'datacontenttype': 'application/json',
      'data': data,
    };

    return await _client.post(
      uri,
      headers: {'content-type': 'application/cloudevents+json'},
      body: jsonEncode(envelope),
    );
  }

  void close() {
    _client.close();
  }
}
