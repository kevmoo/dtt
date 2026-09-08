// Copyright 2026 Google LLC

import 'package:cli_util/cli_util.dart';

/// Resolves the path to the Dart SDK's `dart` executable for subprocess
/// spawning under both JIT and AOT compilation (`dart compile exe` / `dart install`).
String resolveDartExecutable() => dartExecutable ?? 'dart';
