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
import 'dart:convert';

import 'package:async/async.dart';
import 'package:google_cloud_events/google_cloud_triggers.dart';
import 'package:protobuf/protobuf.dart';
import 'package:shelf/shelf.dart';

/// Represents a standardized, strongly-typed CloudEvent envelope payload
/// context.
///
/// Conforms fully to the CNCF CloudEvents v1.0 specification.
class CloudEvent<T extends GeneratedMessage> {
  /// Unique identifier resolving event dispatch profiles.
  final String id;

  /// Signature URI context tracking origin triggers source.
  final Uri source;

  /// The version signature of this CloudEvent specification (typically '1.0').
  final String specVersion;

  /// The unique GCP Eventarc catalog event type descriptor.
  final String type;

  /// The encoding MIME type of the payload
  /// (e.g. application/json, application/protobuf).
  final String? dataContentType;

  /// Optional subject metadata filtering GCP resource targets context.
  final String? subject;

  /// Optional event dispatch trigger time signature.
  final DateTime? time;

  /// The strongly-typed event payload model instances context.
  final T data;

  CloudEvent({
    required this.id,
    required this.source,
    required this.specVersion,
    required this.type,
    required this.dataContentType,
    this.subject,
    this.time,
    required this.data,
  });

  /// Dynamically parses an incoming Shelf request webhook.
  /// Seamlessly detects and handles both Binary and Structured formats,
  /// instantiating a blank message template via [create] and merging values.
  static Future<CloudEvent<T>> parse<T extends GeneratedMessage>(
    Request request,
    T Function() create,
  ) async {
    final contentType = request.headers['content-type'] ?? '';
    final isStructured = contentType.contains('application/cloudevents+json');

    if (isStructured) {
      final bodyStr = await request.readAsString();
      final envelope = jsonDecode(bodyStr) as Map<String, dynamic>;

      final id = envelope['id'] as String? ?? '';
      final source = envelope['source'] as String? ?? '';
      final specVersion = envelope['specversion'] as String? ?? '';
      final type = envelope['type'] as String? ?? '';
      final dataContentType = envelope['datacontenttype'] as String?;
      final subject = envelope['subject'] as String?;
      final timeStr = envelope['time'] as String?;
      final time = timeStr != null ? DateTime.tryParse(timeStr) : null;

      // Instantiate blank message template and merge values natively
      final data = create();

      if (envelope.containsKey('data_base64')) {
        final bytes = base64Decode(envelope['data_base64'] as String);
        data.mergeFromBuffer(bytes);
      } else if (envelope.containsKey('data')) {
        final rawData = envelope['data'];
        if (rawData is String) {
          data.mergeFromJson(rawData);
        } else {
          // Zero-Allocation: map parsed directly without double-serialization!
          data.mergeFromProto3Json(rawData);
        }
      }

      return CloudEvent<T>(
        id: id,
        source: Uri.parse(source),
        specVersion: specVersion,
        type: type,
        dataContentType: dataContentType,
        subject: subject,
        time: time,
        data: data,
      );
    }

    // 2. Resolve binary delivery format (metadata in headers, payload in body)
    final id = request.headers['ce-id'] ?? '';
    final source = request.headers['ce-source'] ?? '';
    final specVersion = request.headers['ce-specversion'] ?? '';
    final type = request.headers['ce-type'] ?? '';
    final dataContentType = request.headers['ce-datacontenttype'];
    final subject = request.headers['ce-subject'];
    final timeStr = request.headers['ce-time'];
    final time = timeStr != null ? DateTime.tryParse(timeStr) : null;

    final data = create();
    final rawBytes = await collectBytes(request.read());

    final isJson = dataContentType != null && dataContentType.contains('json');
    if (isJson) {
      final decodedMap = jsonDecode(utf8.decode(rawBytes));
      data.mergeFromProto3Json(decodedMap);
    } else {
      data.mergeFromBuffer(rawBytes);
    }

    return CloudEvent<T>(
      id: id,
      source: Uri.parse(source),
      specVersion: specVersion,
      type: type,
      dataContentType: dataContentType,
      subject: subject,
      time: time,
      data: data,
    );
  }
}

/// A lightweight, static, high-performance webserver routing engine
/// specifically tailored for resolving Eventarc triggers.
class DttEventRouter {
  final Map<String, _RouteEntry<GeneratedMessage>> _routes = {};

  /// Registers a strongly-typed trigger routing mapping path.
  void register<T extends GeneratedMessage>({
    required String path,
    required String eventType,
    required T Function() create,
    required FutureOr<void> Function(CloudEvent<T> event) handler,
  }) {
    final routeKey = _buildRouteKey(path, eventType);
    _routes[routeKey] = _RouteEntry<T>(create, handler);
  }

  /// Registers a strongly-typed, auto-inferred CloudEvent trigger.
  /// Mapped to type-safe enum definitions, falling back to the trigger's
  /// default path.
  void registerTrigger<T extends GeneratedMessage>({
    required CloudEventTrigger<T> trigger,
    String? path,
    required FutureOr<void> Function(CloudEvent<T> event) handler,
  }) {
    register<T>(
      path: path ?? trigger.defaultPath,
      eventType: trigger.eventType,
      create: trigger.create,
      handler: handler,
    );
  }

  /// Shelf Handler mapping matching path patterns and event types.
  Future<Response> handle(Request request) async {
    // Normalize path signature index matching GCR routing rules
    var path = request.url.path;
    if (!path.startsWith('/')) {
      path = '/$path';
    }

    final contentType = request.headers['content-type'] ?? '';
    final isStructured = contentType.contains('application/cloudevents+json');
    String eventType;

    if (isStructured) {
      // Decode the envelope at router level to fetch target eventType
      final rawBytes = await collectBytes(request.read());
      final bodyStr = utf8.decode(rawBytes);
      final envelope = jsonDecode(bodyStr) as Map<String, dynamic>;

      eventType = envelope['type'] as String? ?? '';

      // Lookup mapped route entry
      final routeKey = _buildRouteKey(path, eventType);
      final entry = _routes[routeKey];
      if (entry == null) {
        return Response.notFound(
          'Unsupported Eventarc trigger route: $path matching $eventType',
        );
      }

      // Re-encapsulate request for envelope parser wrapping decoded JSON
      final structuredRequest = Request(
        request.method,
        request.requestedUri,
        headers: request.headers,
        body: bodyStr,
        context: request.context,
      );

      await entry.parseAndExecute(structuredRequest);
    } else {
      // Binary mode metadata is sent in HTTP headers directly
      eventType = request.headers['ce-type'] ?? '';

      // Lookup mapped route entry
      final routeKey = _buildRouteKey(path, eventType);
      final entry = _routes[routeKey];
      if (entry == null) {
        return Response.notFound(
          'Unsupported Eventarc trigger route: $path matching $eventType',
        );
      }

      await entry.parseAndExecute(request);
    }

    return Response.ok('Event triggering execution complete');
  }

  String _buildRouteKey(String path, String eventType) => '$path|$eventType';
}

class _RouteEntry<T extends GeneratedMessage> {
  final T Function() create;
  final FutureOr<void> Function(CloudEvent<T> event) handler;

  _RouteEntry(this.create, this.handler);

  Future<void> parseAndExecute(Request request) async {
    final event = await CloudEvent.parse<T>(request, create);
    await handler(event);
  }
}
