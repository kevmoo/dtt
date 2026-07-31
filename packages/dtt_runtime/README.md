# Dart Terraform Triggers Runtime (`dtt_runtime`)

Core runtime event parsing, Shelf serverless routing engine, and local CloudEvent simulation harness for `dtt`.

Conforms strictly to canonical Google Cloud Platform (GCP) Eventarc and CloudEvents 1.0 HTTP Protocol Binding specifications.

## 🚀 Usage Guide

### 1. Registering Handlers with `DttEventRouter`

```dart
import 'package:dtt_runtime/dtt_runtime.dart';
import 'package:google_cloud_events/google_cloud_events.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final router = DttEventRouter()
    ..registerTrigger(
      trigger: CloudEventTrigger.gcsObjectFinalized,
      handler: (CloudEvent<StorageObjectData> event) async {
        print('File uploaded: ${event.data.name} in bucket ${event.data.bucket}');
      },
    );

  final pipeline = Pipeline()
    .addMiddleware(logRequests())
    .addHandler(router.handle);

  final server = await io.serve(pipeline, '0.0.0.0', 8080);
  print('Server listening on port ${server.port}');
}
```

### 2. Programmatic Testing with `EventSimulator`

```dart
import 'package:dtt_runtime/dtt_runtime.dart';
import 'package:test/test.dart';

void main() {
  test('Simulate local GCS event', () async {
    final simulator = EventSimulator(targetUrl: 'http://localhost:8080');
    final response = await simulator.sendBinaryEvent(
      path: '/events/uploads',
      eventType: 'google.cloud.storage.object.v1.finalized',
      source: '//storage.googleapis.com/projects/_/buckets/my-bucket',
      data: {'bucket': 'my-bucket', 'name': 'file.txt'},
    );
    expect(response.statusCode, equals(200));
    simulator.close();
  });
}
```
