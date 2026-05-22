# Blueprint Comparison: Functions Framework vs. Static Shelf Micro-Engine

This directory contains concrete, physical implementation mockups displaying how a Google Cloud Storage object finalized event is coded, parsed, and routed under the two primary options outlined in our architectural proposal:

1.  **Option 1 (Annotated FaaS on Functions Framework)**:
    - Located in [option_1_functions_framework/](option_1_functions_framework)
    - Represents how `dtt` will synthesize annotated target files inside your workspace to build on top of Google's official `functions_framework` and run its annotation builder tools.
2.  **Option 2 (Bare Static Shelf Micro-Engine)**:
    - Located in [option_2_static_shelf/](option_2_static_shelf)
    - **(RECOMMENDED)** Represents our reimagined server architecture. It uses no dynamic annotations, runs no slow `build_runner` tasks at compile-time, parses requests directly into static pointers, and boots with zero runtime reflection.

---

## ⚡ Developer Setup & Flow Comparison

### Writing Handlers (The Developer View)
Open both codebases and observe the dramatic difference in readability and type safety:

*   **Option 1 (Current Paradigm - Typeless Envelope)**:
    In [option_1_functions_framework/lib/functions.dart](option_1_functions_framework/lib/functions.dart), the handler signature is forced to receive a typeless `CloudEvent` envelope. The developer must manually execute runtime conversions and type-unsafe casts to unpack fields:
    ```dart
    @CloudFunction()
    void onStorageUpload(CloudEvent event, RequestContext context) {
      final fileMetadata = StorageObjectData.fromBuffer(event.data as List<int>);
      print('Processing upload bucket gs://${fileMetadata.bucket}/${fileMetadata.name}');
    }
    ```

*   **Option 2 (Proposed Paradigm - Fully Typed Callback)**:
    In [option_2_static_shelf/lib/handlers.dart](option_2_static_shelf/lib/handlers.dart), the routing engine automatically performs deserialization behind the scenes. The developer's handler is **100% clean and type-safe** out of the box, with full IDE autocompletions:
    ```dart
    void onStorageUpload(CloudEvent<StorageObjectData> event) {
      final StorageObjectData fileMetadata = event.data;
      print('Processing upload bucket gs://${fileMetadata.bucket}/${fileMetadata.name}');
    }
    ```

---

## 🏗️ Inside the Compilation Engines

-   **Option 1** requires you to configure and launch a heavy Dart compilation task (`dart run build_runner build`) to generate the server endpoint inside [option_1_functions_framework/bin/server.dart](option_1_functions_framework/bin/server.dart).
-   **Option 2** maintains absolute static clarity. The routing registry in [option_2_static_shelf/bin/server.dart](option_2_static_shelf/bin/server.dart) maps event identifiers directly using a standard switch block, booting instantly under AOT compilation with zero dynamic registry steps.
