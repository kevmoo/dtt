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
import 'dart:io';

import 'package:checks/checks.dart';
import 'package:dtt_runtime/dtt_runtime.dart';
import 'package:fixnum/fixnum.dart';
import 'package:google_cloud_events/google_cloud_events.dart';
import 'package:http/http.dart' as http;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';

void main() {
  group('E2E Eventarc Webhook Integration Test', () {
    late HttpServer server;
    late DttEventRouter router;
    late List<CloudEvent<StorageObjectData>> receivedEvents;
    late int port;

    setUp(() async {
      receivedEvents = [];
      router = DttEventRouter()
        ..registerTrigger(
          trigger: CloudEventTrigger.gcsObjectFinalized,
          path: '/events/uploads',
          handler: (event) => receivedEvents.add(event),
        );

      // 2. Mount central shelf pipeline
      final pipeline = const Pipeline()
          .addMiddleware(logRequests())
          .addHandler(router.handle);

      server = await shelf_io.serve(pipeline, InternetAddress.loopbackIPv4, 0);
      port = server.port;
    });

    tearDown(() async {
      await server.close(force: true);
    });

    test('Binary Mode Event Pushes Delivery Flow', () async {
      // 1. Synthesize local model payload variables
      final targetData = StorageObjectData()
        ..bucket = 'my-bucket'
        ..name = 'image.png'
        ..size = Int64(456)
        ..contentType = 'image/png'
        ..updated = (Timestamp()..seconds = Int64(123456789));

      final protoBytes = targetData.writeToBuffer();

      // 2. Dispatch mock Binary HTTP webhook request
      final uri = Uri.parse('http://localhost:$port/events/uploads');
      final response = await http.post(
        uri,
        headers: {
          'ce-id': 'evt_binary_123',
          'ce-source': '//storage.googleapis.com/projects/_/buckets/my-bucket',
          'ce-specversion': '1.0',
          'ce-type': 'google.cloud.storage.object.v1.finalized',
          'ce-datacontenttype': 'application/protobuf',
          'ce-time': '2026-05-21T17:00:00Z',
          'content-type': 'application/octet-stream',
        },
        body: protoBytes,
      );

      // 3. Verify serving resolution matches metrics
      check(response.statusCode).equals(200);

      check(receivedEvents).length.equals(1);
      final event = receivedEvents.first;

      check(event.id).equals('evt_binary_123');
      check(event.type).equals('google.cloud.storage.object.v1.finalized');
      check(event.specVersion).equals('1.0');
      check(
        event.source.toString(),
      ).equals('//storage.googleapis.com/projects/_/buckets/my-bucket');
      check(
        event.time,
      ).isNotNull().equals(DateTime.parse('2026-05-21T17:00:00Z'));

      final payload = event.data;
      check(payload.bucket).equals('my-bucket');
      check(payload.name).equals('image.png');
      check(payload.size).equals(Int64(456));
      check(payload.contentType).equals('image/png');
      check(payload.updated.seconds).equals(Int64(123456789));
    });

    test('Structured Mode (JSON Envelope with base64 Data) Flow', () async {
      // 1. Encode GCS payload data to base64 string
      final targetData = StorageObjectData()
        ..bucket = 'another-bucket'
        ..name = 'doc.pdf'
        ..size = Int64(1024)
        ..contentType = 'application/pdf';

      final protoBytes = targetData.writeToBuffer();
      final base64Payload = base64Encode(protoBytes);

      // 2. Synthesize structured envelope payload
      final envelope = {
        'id': 'evt_struct_456',
        'source': '//storage.googleapis.com/projects/_/buckets/another-bucket',
        'specversion': '1.0',
        'type': 'google.cloud.storage.object.v1.finalized',
        'datacontenttype': 'application/protobuf',
        'time': '2026-05-21T18:30:00Z',
        'data_base64': base64Payload,
      };

      final jsonBody = jsonEncode(envelope);

      // 3. Dispatch structured HTTP webhook request
      final uri = Uri.parse('http://localhost:$port/events/uploads');
      final response = await http.post(
        uri,
        headers: {
          'content-type': 'application/cloudevents+json; charset=utf-8',
        },
        body: jsonBody,
      );

      // 4. Assert routing resolves cleanly
      check(response.statusCode).equals(200);
      check(receivedEvents).length.equals(1);

      final event = receivedEvents.first;
      check(event.id).equals('evt_struct_456');
      check(event.type).equals('google.cloud.storage.object.v1.finalized');
      check(
        event.time,
      ).isNotNull().equals(DateTime.parse('2026-05-21T18:30:00Z'));

      final payload = event.data;
      check(payload.bucket).equals('another-bucket');
      check(payload.name).equals('doc.pdf');
      check(payload.size).equals(Int64(1024));
      check(payload.contentType).equals('application/pdf');
    });

    test('Structured Mode with standard JSON Data Payload Flow', () async {
      // 1. Assemble JSON payload structured webhook
      final envelope = {
        'id': 'evt_json_789',
        'source': '//storage.googleapis.com/projects/_/buckets/json-bucket',
        'specversion': '1.0',
        'type': 'google.cloud.storage.object.v1.finalized',
        'datacontenttype': 'application/json',
        'data': {
          'bucket': 'json-bucket',
          'name': 'data.json',
          'size': '789',
          'contentType': 'application/json',
        },
      };

      final jsonBody = jsonEncode(envelope);

      // 2. Dispatch request matching JSON fallback parsing
      final uri = Uri.parse('http://localhost:$port/events/uploads');
      final response = await http.post(
        uri,
        headers: {'content-type': 'application/cloudevents+json'},
        body: jsonBody,
      );

      // 3. Assert successful mapping
      check(response.statusCode).equals(200);
      check(receivedEvents).length.equals(1);

      final event = receivedEvents.first;
      check(event.id).equals('evt_json_789');
      check(event.dataContentType).equals('application/json');

      final payload = event.data;
      check(payload.bucket).equals('json-bucket');
      check(payload.name).equals('data.json');
      check(payload.size).equals(Int64(789));
      check(payload.contentType).equals('application/json');
    });

    test(
      'Returns 400 Bad Request on malformed JSON or non-Map roots',
      () async {
        final uri = Uri.parse('http://localhost:$port/events/uploads');

        // Malformed JSON
        final malformedRes = await http.post(
          uri,
          headers: {'content-type': 'application/cloudevents+json'},
          body: '{bad json',
        );
        check(malformedRes.statusCode).equals(400);
        check(malformedRes.body).contains('malformed JSON');

        // JSON Array instead of JSON Object Map
        final arrayRes = await http.post(
          uri,
          headers: {'content-type': 'application/cloudevents+json'},
          body: '["not", "a", "map"]',
        );
        check(arrayRes.statusCode).equals(400);
        check(arrayRes.body).contains('expected a JSON object');
      },
    );

    test(
      'Returns 400 Bad Request on malformed inner CloudEvent attributes',
      () async {
        final uri = Uri.parse('http://localhost:$port/events/uploads');
        final pubsubUri = Uri.parse(
          'http://localhost:$port/events/uploads?__GCP_CloudEventsMode=CE_PUBSUB_BINDING',
        );

        // Pub/Sub mode where message is a string instead of map
        final pubsubRes = await http.post(
          pubsubUri,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({'message': 'not a map'}),
        );
        check(pubsubRes.statusCode).equals(400);
        check(pubsubRes.body).contains('missing ce-type attribute');

        // Structured mode where type is an integer instead of string
        final structRes = await http.post(
          uri,
          headers: {'content-type': 'application/cloudevents+json'},
          body: jsonEncode({'type': 12345}),
        );
        check(structRes.statusCode).equals(400);
        check(structRes.body).contains('missing type attribute');
      },
    );

    test(
      'Returns 400 Bad Request on malformed Protobuf JSON payloads',
      () async {
        final uri = Uri.parse('http://localhost:$port/events/uploads');

        // Structured mode where data is an array instead of map/string
        final badDataRes = await http.post(
          uri,
          headers: {'content-type': 'application/cloudevents+json'},
          body: jsonEncode({
            'id': 'evt_bad_data',
            'source': '//test',
            'specversion': '1.0',
            'type': 'google.cloud.storage.object.v1.finalized',
            'data': [1, 2, 3],
          }),
        );
        check(badDataRes.statusCode).equals(400);
        check(badDataRes.body).contains('Expected a JSON object');
      },
    );

    test('Returns 400 Bad Request on invalid UTF-8 byte streams', () async {
      final uri = Uri.parse('http://localhost:$port/events/uploads');

      final badUtf8Res = await http.post(
        uri,
        headers: {'content-type': 'application/cloudevents+json'},
        body: [0xFF, 0xFE, 0xFD],
      );
      check(badUtf8Res.statusCode).equals(400);
      check(badUtf8Res.body).contains('malformed JSON');
    });
  });
}
