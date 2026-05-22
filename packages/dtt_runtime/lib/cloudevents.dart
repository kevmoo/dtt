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
import 'package:shelf/shelf.dart';

/// Represents a standardized, type-safe CloudEvent envelope payload context.
/// Conforms fully to the CNCF CloudEvents v1.0 specification.
class CloudEvent<T> {
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
  /// collecting stream bytes and mapping payloads recursively via [dataParser].
  static Future<CloudEvent<T>> parse<T>(
    Request request,
    FutureOr<T> Function(List<int> bytes, String? contentType) dataParser,
  ) async {
    final contentType = request.headers['content-type'] ?? '';

    // 1. Resolve structured format (envelope inside JSON body)
    if (contentType.contains('application/cloudevents+json')) {
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

      // Unpack bytes (Structured mode handles base64 strings for binaries)
      List<int> bytes;
      if (envelope.containsKey('data_base64')) {
        bytes = base64Decode(envelope['data_base64'] as String);
      } else if (envelope.containsKey('data')) {
        final rawData = envelope['data'];
        if (rawData is String) {
          bytes = utf8.encode(rawData);
        } else {
          // Standard JSON payload objects encoded back to standard bytes
          bytes = utf8.encode(jsonEncode(rawData));
        }
      } else {
        bytes = const [];
      }

      final data = await dataParser(bytes, dataContentType);

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

    // 2. Resolve binary format (metadata in headers, payload in body)
    final id = request.headers['ce-id'] ?? '';
    final source = request.headers['ce-source'] ?? '';
    final specVersion = request.headers['ce-specversion'] ?? '';
    final type = request.headers['ce-type'] ?? '';
    final dataContentType = request.headers['ce-datacontenttype'];
    final subject = request.headers['ce-subject'];
    final timeStr = request.headers['ce-time'];
    final time = timeStr != null ? DateTime.tryParse(timeStr) : null;

    // Collect stream bytes using high-performance, no-copy collectors buffers
    final rawBytes = await collectBytes(request.read());
    final data = await dataParser(rawBytes, dataContentType);

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
  final Map<String, _RouteEntry<dynamic>> _routes = {};

  /// Registers a strongly-typed trigger routing mapping path.
  void register<T>({
    required String path,
    required String eventType,
    required FutureOr<T> Function(List<int> bytes, String? contentType)
    dataParser,
    required FutureOr<void> Function(CloudEvent<T> event) handler,
  }) {
    final routeKey = _buildRouteKey(path, eventType);
    _routes[routeKey] = _RouteEntry<T>(dataParser, handler);
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

class _RouteEntry<T> {
  final FutureOr<T> Function(List<int> bytes, String? contentType) dataParser;
  final FutureOr<void> Function(CloudEvent<T> event) handler;

  _RouteEntry(this.dataParser, this.handler);

  Future<void> parseAndExecute(Request request) async {
    final event = await CloudEvent.parse<T>(request, dataParser);
    await handler(event);
  }
}
