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

import 'cloudevent.dart';
import 'constants.dart';

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
    final contentType = request.headers['content-type'] ?? '';
    final isStructured = contentType.contains('application/cloudevents+json');

    String eventType;
    var targetRequest = request;

    if (isPubSubBinding || isStructured) {
      final rawBytes = await collectBytes(request.read());
      final bodyStr = utf8.decode(rawBytes);
      final Map<String, dynamic> envelope;
      try {
        final decoded = jsonDecode(bodyStr);
        if (decoded is! Map<String, dynamic>) {
          throw const BadEnvelopeException(
            'Invalid CloudEvent envelope: expected a JSON object.',
          );
        }
        envelope = decoded;

        if (isPubSubBinding) {
          eventType = switch (envelope) {
            {'message': {'attributes': {'ce-type': String s}}} => s,
            {'message': {'attributes': {'type': String s}}} => s,
            _ => throw const BadEnvelopeException(
              'Invalid Pub/Sub binding: missing ce-type attribute.',
            ),
          };
        } else {
          eventType = switch (envelope) {
            {'type': String s} => s,
            _ => throw const BadEnvelopeException(
              'Invalid Structured CloudEvent: missing type attribute.',
            ),
          };
        }
      } on FormatException {
        return Response.badRequest(
          body: 'Invalid CloudEvent envelope: malformed JSON.',
        );
      } on BadEnvelopeException catch (e) {
        return Response.badRequest(body: e.message);
      }

      targetRequest = request.change(
        body: bodyStr,
        context: {envelopeContextKey: envelope},
      );
    } else {
      eventType = request.headers['ce-type'] ?? '';
    }

    final routeKey = _buildRouteKey(path, eventType);
    final entry = _routes[routeKey];
    if (entry == null) {
      return Response.notFound(
        'Unsupported Eventarc trigger route: $path matching $eventType',
      );
    }

    try {
      await entry.parseAndExecute(targetRequest);
    } on FormatException catch (e) {
      return Response.badRequest(
        body: 'Invalid event payload: malformed JSON (${e.message}).',
      );
    } on InvalidProtocolBufferException catch (e) {
      return Response.badRequest(
        body: 'Invalid event payload: malformed Protobuf (${e.message}).',
      );
    } on BadEnvelopeException catch (e) {
      return Response.badRequest(body: e.message);
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
