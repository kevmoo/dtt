// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dtt_runtime/dtt_runtime.dart';
import 'package:path/path.dart' as p;

import '../../codegen/generator.dart';

/// Command [dtt dev] for local server booting and local event simulation test harness.
class DevCommand extends Command<void> {
  @override
  final String name = 'dev';

  @override
  final String description =
      'Boots local development Shelf server and runs local CloudEvent simulations.';

  DevCommand() {
    argParser
      ..addOption(
        'package-dir',
        abbr: 'p',
        help: 'Target package folder path (defaults to current directory).',
      )
      ..addOption(
        'port',
        help: 'Local server port for development testing.',
        defaultsTo: '8080',
      )
      ..addOption(
        'emit-event',
        help:
            'CloudEvent type to emit locally (e.g. google.cloud.storage.object.v1.finalized).',
      )
      ..addOption(
        'payload',
        help: 'Path to JSON fixture file or inline JSON string data.',
      )
      ..addOption(
        'path',
        help: 'Target HTTP path endpoint for local event simulation.',
        defaultsTo: '/events/uploads',
      );
  }

  @override
  Future<void> run() async {
    final packageDir =
        argResults?['package-dir'] as String? ?? Directory.current.path;
    final portStr = argResults?['port'] as String? ?? '8080';
    final port = int.tryParse(portStr) ?? 8080;
    final emitEvent = argResults?['emit-event'] as String?;
    final payload = argResults?['payload'] as String?;
    final eventPath = argResults?['path'] as String? ?? '/events/uploads';

    final workspaceRoot = _resolveWorkspaceRoot(packageDir);

    // Generate bin/server.dart first
    await generateProject(workspaceRoot: workspaceRoot, packageDir: packageDir);

    if (emitEvent != null) {
      // Run local event simulation!
      Map<String, dynamic> data = {'simulated': true};
      if (payload != null) {
        if (File(payload).existsSync()) {
          data =
              jsonDecode(await File(payload).readAsString())
                  as Map<String, dynamic>;
        } else {
          try {
            data = jsonDecode(payload) as Map<String, dynamic>;
          } catch (e) {
            print(
              '⚠️ Warning: Invalid JSON payload supplied ("$payload"): $e. Defaulting to fallback payload.',
            );
          }
        }
      }

      print(
        '🚀 Emitting simulated CloudEvent [$emitEvent] to http://localhost:$port$eventPath...',
      );
      final simulator = EventSimulator(targetUrl: 'http://localhost:$port');
      final res = await simulator.sendBinaryEvent(
        path: eventPath,
        eventType: emitEvent,
        source: '//local/dev/simulator',
        data: data,
      );

      print('Status: ${res.statusCode}');
      print('Response: ${res.body}');
      simulator.close();
      return;
    }

    print('🚀 Starting local development server on http://localhost:$port...');
    final serverFile = File(p.join(packageDir, 'bin', 'server.dart'));
    final process = await Process.start(
      'dart',
      ['run', serverFile.path],
      environment: {'PORT': '$port'},
      mode: ProcessStartMode.inheritStdio,
    );

    await process.exitCode;
  }

  String _resolveWorkspaceRoot(String startPath) {
    var dir = Directory(startPath).absolute;
    while (dir.parent.path != dir.path) {
      final tfDir = Directory(p.join(dir.path, 'terraform'));
      if (tfDir.existsSync()) {
        return dir.path;
      }
      dir = dir.parent;
    }
    return startPath;
  }
}
