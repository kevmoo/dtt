// Copyright 2026 Google LLC

import 'dart:io';

import 'package:checks/checks.dart';
import 'package:dtt/src/util/dart_sdk.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('resolveDartExecutable', () {
    test('returns Platform.resolvedExecutable in JIT mode', () {
      final exe = resolveDartExecutable(
        resolvedExecutable: '/usr/lib/dart/bin/dart',
        script: Uri.parse('file:///path/to/script.dart'),
      );
      check(exe).equals('/usr/lib/dart/bin/dart');
    });

    test('probes DART_SDK when executable is not named dart (AOT mode)', () {
      final tempDir = Directory.systemTemp.createTempSync('dart_sdk_test_');
      try {
        final binDir = Directory(p.join(tempDir.path, 'bin'))
          ..createSync(recursive: true);
        final exeName = Platform.isWindows ? 'dart.exe' : 'dart';
        final mockDart = File(p.join(binDir.path, exeName))
          ..writeAsStringSync('');

        final exe = resolveDartExecutable(
          resolvedExecutable: '/usr/local/bin/dtt',
          script: Uri.parse('file:///path/to/script.dart'),
          environment: {'DART_SDK': tempDir.path},
        );
        check(exe).equals(mockDart.path);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test(
      'probes FLUTTER_ROOT when script equals resolvedExecutable (AOT mode)',
      () {
        final tempDir = Directory.systemTemp.createTempSync(
          'flutter_sdk_test_',
        );
        try {
          final binDir = Directory(
            p.join(tempDir.path, 'bin', 'cache', 'dart-sdk', 'bin'),
          )..createSync(recursive: true);
          final exeName = Platform.isWindows ? 'dart.exe' : 'dart';
          final mockDart = File(p.join(binDir.path, exeName))
            ..writeAsStringSync('');

          final exe = resolveDartExecutable(
            resolvedExecutable: '/usr/local/bin/dtt',
            script: Uri.parse('file:///usr/local/bin/dtt'),
            environment: {'FLUTTER_ROOT': tempDir.path},
          );
          check(exe).equals(mockDart.path);
        } finally {
          tempDir.deleteSync(recursive: true);
        }
      },
    );

    test('probes PATH traversal in AOT mode', () {
      final tempDir = Directory.systemTemp.createTempSync('path_sdk_test_');
      try {
        final exeName = Platform.isWindows ? 'dart.exe' : 'dart';
        final mockDart = File(p.join(tempDir.path, exeName))
          ..writeAsStringSync('');

        final exe = resolveDartExecutable(
          resolvedExecutable: '/usr/local/bin/dtt',
          script: Uri.parse('file:///usr/local/bin/dtt'),
          environment: {'PATH': tempDir.path},
        );
        check(exe).equals(mockDart.path);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test(
      'falls back to bare executable name if no candidates exist in AOT mode',
      () {
        final exe = resolveDartExecutable(
          resolvedExecutable: '/usr/local/bin/dtt',
          script: Uri.parse('file:///usr/local/bin/dtt'),
          environment: {'PATH': '', 'DART_SDK': '', 'FLUTTER_ROOT': ''},
        );
        check(exe).equals(Platform.isWindows ? 'dart.exe' : 'dart');
      },
    );
  });
}
