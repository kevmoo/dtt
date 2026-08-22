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

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;

import '../../codegen/generator.dart';
import '../../util/workspace.dart';

class GenerateCommand extends Command<void> {
  @override
  final String name = 'generate';

  @override
  final String description =
      'Generate type-safe Dart models, route handlers, and declarative '
      'Terraform configuration manifests.';

  GenerateCommand() {
    argParser
      ..addOption(
        'package-dir',
        abbr: 'p',
        defaultsTo: '.',
        help: 'Path to target package directory containing dtt.yaml.',
      )
      ..addFlag(
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
    final packageDirParam = argResults?['package-dir'] as String? ?? '.';
    final packageDir = p.canonicalize(packageDirParam);
    final workspaceRoot =
        findWorkspaceRoot(packageDir) ?? p.dirname(packageDir);

    print(
      'Generating serverless triggers manifests inside workspace: '
      '$workspaceRoot for package: $packageDir...',
    );

    await generateProject(workspaceRoot: workspaceRoot, packageDir: packageDir);
    print('Code and Terraform manifests generated successfully!');
  }
}
