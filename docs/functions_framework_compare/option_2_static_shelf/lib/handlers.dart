import 'cloudevents.dart';
import 'src/generated/storage_object_data.dart';

/// Type-safe callback handling file finalizations in Google Cloud Storage.
/// Under Option 2, the routing server automatically deserializes the payload,
/// exposing strongly typed fields with IDE autocompletions out-of-the-box.
void onStorageUpload(CloudEvent<StorageObjectData> event) {
  // 🌟 NO BOTTLENECKS, NO CASTING:
  // event.data is natively mapped to StorageObjectData
  final StorageObjectData fileMetadata = event.data;

  print('Trigger event ID resolved: ${event.id}');
  print('Event source: ${event.source}');
  print('File processed successfully! (Type-safe execution)');
  print('File Name: ${fileMetadata.name}');
  print('Bucket Path: gs://${fileMetadata.bucket}/${fileMetadata.name}');
  print('File Size: ${fileMetadata.size} bytes');
  print('Content Type: ${fileMetadata.contentType}');
  print('Last Updated: ${fileMetadata.updated}');
}
