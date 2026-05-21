import 'package:functions_framework/functions_framework.dart';
import 'src/generated/storage_object_data.dart';

/// Type-generic target handler registered with standard Google Functions Framework
/// annotations. Notice the typeless parameters forcing manual casting at runtime.
@CloudFunction()
void onStorageUpload(CloudEvent event, RequestContext context) {
  context.logger.info('Trigger event ID resolved: ${event.id}');
  context.logger.info('Event type: ${event.type}');

  // 🚨 RUNTIME CASTING BOTTLENECK:
  // The framework delivers event.data as generic 'Object?'.
  // The developer must explicitly cast and manually run parsing.
  if (event.data is! List<int>) {
    context.logger.error(
        'Failed to unpack event payload: expected List<int> binary buffer.');
    return;
  }

  try {
    final fileMetadata = StorageObjectData.fromBuffer(event.data as List<int>);

    // Type-safe autocompleted operations inside business logic
    context.logger.info('File upload processed successfully!');
    context.logger.info('File Name: ${fileMetadata.name}');
    context.logger
        .info('Bucket Path: gs://${fileMetadata.bucket}/${fileMetadata.name}');
    context.logger.info('File Size: ${fileMetadata.size} bytes');
  } catch (e, stack) {
    context.logger
        .error('Failed to decode StorageObjectData payload: $e\n$stack');
  }
}
