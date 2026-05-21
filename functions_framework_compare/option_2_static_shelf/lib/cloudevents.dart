import 'dart:convert';
import 'dart:typed_data';
import 'package:shelf/shelf.dart';

/// Represents a strongly-typed CloudEvents v1.0 standard packet structure.
class CloudEvent<T> {
  final String id;
  final Uri source;
  final String specVersion;
  final String type;
  final String? dataContentType;
  final T data;

  CloudEvent({
    required this.id,
    required this.source,
    required this.specVersion,
    required this.type,
    required this.dataContentType,
    required this.data,
  });

  /// Single-pass parser resolving incoming Shelf [Request] objects directly into
  /// a type-safe [CloudEvent<T>] wrapper, bypassing reflection.
  static Future<CloudEvent<T>> parse<T>(
    Request request,
    T Function(List<int> bytes) dataParser,
  ) async {
    final contentType = request.headers['content-type'] ?? '';

    if (contentType.contains('application/cloudevents+json')) {
      // 1. STRUCTURED MODE: Entire envelope represents a JSON object inside HTTP body
      final bodyBytes = await request.readBytes();
      final Map<String, dynamic> envelope =
          jsonDecode(utf8.decode(bodyBytes)) as Map<String, dynamic>;

      final rawData = envelope['data'];
      final List<int> payloadBytes;

      if (rawData is String) {
        payloadBytes = utf8.encode(rawData);
      } else if (rawData is Map || rawData is List) {
        payloadBytes = utf8.encode(jsonEncode(rawData));
      } else {
        payloadBytes = const [];
      }

      return CloudEvent<T>(
        id: envelope['id'] as String? ?? '',
        source: Uri.parse(envelope['source'] as String? ?? ''),
        specVersion: envelope['specversion'] as String? ?? '1.0',
        type: envelope['type'] as String? ?? '',
        dataContentType: envelope['datacontenttype'] as String?,
        data: dataParser(payloadBytes),
      );
    } else {
      // 2. BINARY MODE: Envelope metadata inside HTTP headers; raw payload inside body
      final id = request.headers['ce-id'] ?? '';
      final source = request.headers['ce-source'] ?? '';
      final specVersion = request.headers['ce-specversion'] ?? '1.0';
      final type = request.headers['ce-type'] ?? '';
      final dataContentType = request.headers['ce-datacontenttype'];

      final bodyBytes = await request.readBytes();

      return CloudEvent<T>(
        id: id,
        source: Uri.parse(source),
        specVersion: specVersion,
        type: type,
        dataContentType: dataContentType,
        data: dataParser(bodyBytes),
      );
    }
  }
}

extension RequestExt on Request {
  /// Standard, zero-copy buffer aggregator mapping Shelf's body stream.
  Future<List<int>> readBytes() async {
    final length = contentLength;
    if (length == null) {
      return await read().fold<List<int>>(
        <int>[],
        (previous, element) => previous..addAll(element),
      );
    }
    final bytes = Uint8List(length);
    var offset = 0;
    await for (var bits in read()) {
      bytes.setAll(offset, bits);
      offset += bits.length;
    }
    return bytes;
  }
}
