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

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;

import '../../codegen/generator.dart';

class GenerateCommand extends Command<void> {
  @override
  final String name = 'generate';

  @override
  final String description =
      'Generate type-safe Dart models, route handlers, and declarative '
      'Terraform configuration manifests.';

  GenerateCommand() {
    argParser.addFlag(
      'force',
      abbr: 'f',
      negatable: false,
      help:
          'Force regeneration and override existing files in the workspace '
          '(including handler callbacks).',
    );
  }

  @override
  Future<void> run() async {
    final currentDir = Directory.current.path;
    final workspaceRoot = _findWorkspaceRoot(currentDir);

    if (workspaceRoot == null) {
      throw StateError(
        'Could not locate workspace root. '
        'Ensure you run this command inside a Dart monorepo workspace '
        'member directory.',
      );
    }

    print(
      'Generating serverless triggers manifests inside workspace: '
      '$workspaceRoot...',
    );

    await generateProject(workspaceRoot: workspaceRoot, packageDir: currentDir);
    print('Code and Terraform manifests generated successfully!');
  }

  String? _findWorkspaceRoot(String startDir) {
    var dir = Directory(startDir);
    while (true) {
      final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
      if (pubspec.existsSync()) {
        final content = pubspec.readAsStringSync();
        if (content.contains('workspace:')) {
          return dir.path;
        }
      }
      final parent = dir.parent;
      if (parent.path == dir.path) {
        break; // Reached filesystem root
      }
      dir = parent;
    }
    return null;
  }
}
