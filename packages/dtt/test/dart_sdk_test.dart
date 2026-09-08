// Copyright 2026 Google LLC

import 'dart:io';

import 'package:checks/checks.dart';
import 'package:dtt/src/util/dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('resolveDartExecutable', () {
    test('returns a valid dart executable path', () {
      final exe = resolveDartExecutable();
      check(exe).isNotEmpty();
      if (exe != 'dart') {
        check(File(exe).existsSync()).isTrue();
      }
    });
  });
}
