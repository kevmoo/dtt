// Copyright 2026 Google LLC

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

/// Resolves the path to the Dart SDK's `dart` executable for subprocess
/// spawning.
///
/// In JIT VM mode (e.g. during `dart run` or `dart test`),
/// [Platform.resolvedExecutable] points directly to the running `dart` VM
/// binary.
///
/// In AOT-compiled mode (e.g. when `dtt` is compiled via `dart compile exe` or
/// installed via `dart install`), [Platform.resolvedExecutable] points to the
/// `dtt` binary itself. In that case, this function probes:
/// 1. `DART_SDK` / `DART_ROOT` environment variables.
/// 2. `FLUTTER_ROOT` cache (`$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart`).
/// 3. The system `PATH` for `dart` or `dart.exe`.
///
/// The optional parameters exist strictly for unit testing.
///
/// TODO(https://github.com/dart-lang/tools/issues/2504): Remove this helper once
/// `package:cli_util` publishes canonical AOT-resilient SDK discovery.
String resolveDartExecutable({
  @visibleForTesting Uri? script,
  @visibleForTesting String? resolvedExecutable,
  @visibleForTesting Map<String, String>? environment,
}) {
  script ??= Platform.script;
  resolvedExecutable ??= Platform.resolvedExecutable;
  environment ??= Platform.environment;

  final isCompiledExe =
      (script.isScheme('file') && script.toFilePath() == resolvedExecutable) ||
      p.basenameWithoutExtension(resolvedExecutable).toLowerCase() != 'dart';

  if (!isCompiledExe) {
    return resolvedExecutable;
  }

  final exeName = Platform.isWindows ? 'dart.exe' : 'dart';

  // Tier 1: DART_SDK or DART_ROOT
  final dartSdkEnv = environment['DART_SDK'] ?? environment['DART_ROOT'];
  if (dartSdkEnv != null && dartSdkEnv.isNotEmpty) {
    final candidate = p.join(dartSdkEnv, 'bin', exeName);
    if (File(candidate).existsSync()) {
      return candidate;
    }
  }

  // Tier 2: FLUTTER_ROOT cache
  final flutterRoot = environment['FLUTTER_ROOT'];
  if (flutterRoot != null && flutterRoot.isNotEmpty) {
    final candidate = p.join(
      flutterRoot,
      'bin',
      'cache',
      'dart-sdk',
      'bin',
      exeName,
    );
    if (File(candidate).existsSync()) {
      return candidate;
    }
  }

  // Tier 3: PATH traversal
  final pathEnv = environment['PATH'];
  if (pathEnv != null && pathEnv.isNotEmpty) {
    final separator = Platform.isWindows ? ';' : ':';
    for (final dir in pathEnv.split(separator)) {
      if (dir.isEmpty) continue;
      final candidate = p.join(dir, exeName);
      if (File(candidate).existsSync()) {
        return candidate;
      }
    }
  }

  // Fallback to bare executable name
  return exeName;
}
