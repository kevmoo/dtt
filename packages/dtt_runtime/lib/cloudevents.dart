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
    final isPubSubBinding =
        request.requestedUri.queryParameters['__GCP_CloudEventsMode'] ==
        'CE_PUBSUB_BINDING';

    final jsonMap = <String, dynamic>{};

    if (isPubSubBinding) {
      final bodyStr = await request.readAsString();
      final envelope = jsonDecode(bodyStr) as Map<String, dynamic>;

      final message = envelope['message'] as Map<String, dynamic>? ?? {};
      final attributes = message['attributes'] as Map<String, dynamic>? ?? {};

      // 1. Dynamically harvest all attributes, stripping 'ce-' prefix!
      for (final entry in attributes.entries) {
        final key = entry.key.startsWith('ce-')
            ? entry.key.substring(3)
            : entry.key;
        jsonMap[key] = entry.value;
      }

      // 2. Unpack the base64-encoded data payload
      if (message.containsKey('data')) {
        final rawData = message['data'] as String;
        final decodedBytes = base64Decode(rawData);

        final dataContentType = jsonMap['datacontenttype'] as String?;
        final isJson =
            dataContentType != null && dataContentType.contains('json');

        final data = create();
        if (isJson) {
          final decodedMap = jsonDecode(utf8.decode(decodedBytes));
          data.mergeFromProto3Json(decodedMap);
        } else {
          data.mergeFromBuffer(decodedBytes);
        }

        jsonMap['data_model'] = data;
      }
    } else {
      final contentType = request.headers['content-type'] ?? '';
      final isStructured = contentType.contains('application/cloudevents+json');

      if (isStructured) {
        final bodyStr = await request.readAsString();
        final envelope = jsonDecode(bodyStr) as Map<String, dynamic>;
        jsonMap.addAll(envelope);

        final data = create();
        if (envelope.containsKey('data_base64')) {
          final bytes = base64Decode(envelope['data_base64'] as String);
          data.mergeFromBuffer(bytes);
        } else if (envelope.containsKey('data')) {
          final rawData = envelope['data'];
          if (rawData is String) {
            data.mergeFromJson(rawData);
          } else {
            data.mergeFromProto3Json(rawData);
          }
        }
        jsonMap['data_model'] = data;
      } else {
        // Binary mode: dynamically harvest all headers starting with 'ce-'!
        for (final entry in request.headers.entries) {
          if (entry.key.startsWith('ce-')) {
            jsonMap[entry.key.substring(3)] = entry.value;
          }
        }
        if (request.headers.containsKey('content-type')) {
          jsonMap['datacontenttype'] = request.headers['content-type'];
        }

        final data = create();
        final rawBytes = await collectBytes(request.read());
        final dataContentType = jsonMap['datacontenttype'] as String?;
        final isJson =
            dataContentType != null && dataContentType.contains('json');
        if (isJson) {
          final decodedMap = jsonDecode(utf8.decode(rawBytes));
          data.mergeFromProto3Json(decodedMap);
        } else {
          data.mergeFromBuffer(rawBytes);
        }
        jsonMap['data_model'] = data;
      }
    }

    // 3. Construct CloudEvent from unified harvested JSON map!
    return CloudEvent<T>(
      id: jsonMap['id'] as String? ?? '',
      source: Uri.parse(jsonMap['source'] as String? ?? ''),
      specVersion:
          (jsonMap['specversion'] ?? jsonMap['specversion']) as String? ?? '',
      type: jsonMap['type'] as String? ?? '',
      dataContentType: jsonMap['datacontenttype'] as String?,
      subject: jsonMap['subject'] as String?,
      time: jsonMap['time'] != null
          ? DateTime.tryParse(jsonMap['time'] as String)
          : null,
      data: jsonMap['data_model'] as T,
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

    final isPubSubBinding =
        request.requestedUri.queryParameters['__GCP_CloudEventsMode'] ==
        'CE_PUBSUB_BINDING';

    String eventType;
    Request processedRequest;

    if (isPubSubBinding) {
      // 1. Decode Structured Pub/Sub Push Envelope to fetch target eventType
      final rawBytes = await collectBytes(request.read());
      final bodyStr = utf8.decode(rawBytes);
      final envelope = jsonDecode(bodyStr) as Map<String, dynamic>;

      final message = envelope['message'] as Map<String, dynamic>? ?? {};
      final attributes = message['attributes'] as Map<String, dynamic>? ?? {};

      eventType =
          (attributes['ce-type'] ?? attributes['type']) as String? ?? '';

      // Lookup mapped route entry
      final routeKey = _buildRouteKey(path, eventType);
      final entry = _routes[routeKey];
      if (entry == null) {
        return Response.notFound(
          'Unsupported Eventarc trigger route: $path matching $eventType',
        );
      }

      // Re-encapsulate request body for parser wrapping decoded JSON
      processedRequest = Request(
        request.method,
        request.requestedUri,
        headers: request.headers,
        body: bodyStr,
        context: request.context,
      );

      await entry.parseAndExecute(processedRequest);
    } else {
      final contentType = request.headers['content-type'] ?? '';
      final isStructured = contentType.contains('application/cloudevents+json');

      if (isStructured) {
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

        // Re-encapsulate request body for parser wrapping decoded JSON
        processedRequest = Request(
          request.method,
          request.requestedUri,
          headers: request.headers,
          body: bodyStr,
          context: request.context,
        );

        await entry.parseAndExecute(processedRequest);
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
