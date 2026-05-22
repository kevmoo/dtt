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
  void run() {
    print('Command generate initiated. Args parsed: ${argResults?.options}');
  }
}
