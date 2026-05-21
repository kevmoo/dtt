import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:thought_2_terraform_style/cloudevents.dart';
import 'package:thought_2_terraform_style/src/generated/storage_object_data.dart';

void main(List<String> args) async {
  final portStr = Platform.environment['PORT'] ?? '8080';
  final port = int.tryParse(portStr) ?? 8080;

  final pipeline = const Pipeline()
      .addMiddleware(_gcpStructuredLoggingMiddleware)
      .addHandler(_router);

  final server = await shelf_io.serve(pipeline, InternetAddress.anyIPv4, port);
  print('Listening on port :${server.port} (GCP Static Triggers Server)');
}

/// Dynamic routing resolver using static switch mapping pointers
Future<Response> _router(Request request) async {
  if (request.url.path == 'healthz' || request.url.path == '') {
    return Response.ok('Healthy');
  }

  final eventType = request.headers['ce-type'] ?? '';
  final path = request.url.path;

  // 🌟 PURE GCP ROUTING BLOCK:
  // Static matches routing path and event trigger signature.
  if (path == 'events/storage' &&
      eventType == 'google.cloud.storage.object.v1.finalized') {
    try {
      // Direct, zero-reflection parsing pipeline straight to compiled Protobuf Model
      final event = await CloudEvent.parse<StorageObjectData>(
        request,
        (bytes) => StorageObjectData.fromBuffer(bytes),
      );

      // Business logic execution
      _onStorageUpload(event);

      return Response.ok('Success');
    } catch (e, stack) {
      stderr.writeln('Processing failed: $e\n$stack');
      return Response.internalServerError();
    }
  }

  return Response.notFound('Event handler not found.');
}

/// Strongly-typed developer callback
void _onStorageUpload(CloudEvent<StorageObjectData> event) {
  final StorageObjectData metadata = event.data;

  print('Processed Storage Event ID: ${event.id}');
  print('File Bucket: ${metadata.bucket}');
  print('File Name: ${metadata.name}');
  print('File Size: ${metadata.size} bytes');
}

/// GCP structured logging middleware
Middleware _gcpStructuredLoggingMiddleware = (Handler innerHandler) {
  return (Request request) async {
    final response = await innerHandler(request);
    final traceHeader = request.headers['x-cloud-trace-context'] ?? '';
    final traceId = traceHeader.split('/').first;

    final logMessage = {
      'severity': response.statusCode >= 500 ? 'ERROR' : 'INFO',
      'message':
          '${request.method} ${request.url.path} -> HTTP ${response.statusCode}',
      'httpRequest': {
        'requestMethod': request.method,
        'requestUrl': request.requestedUri.toString(),
        'status': response.statusCode,
      },
      if (traceId.isNotEmpty) 'logging.googleapis.com/trace': traceId,
    };

    print(jsonEncode(logMessage));
    return response;
  };
};
