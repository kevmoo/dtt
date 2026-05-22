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

class DeployCommand extends Command<void> {
  @override
  final String name = 'deploy';

  @override
  final String description =
      'Orchestrate Dart release container builds, push container '
      'images, and execute Terraform GCP resource provisioning.';

  DeployCommand() {
    argParser
      ..addOption(
        'image',
        abbr: 'i',
        help:
            'Target repository path tag reference for the Docker container '
            'image. Auto-derived if omitted.',
      )
      ..addFlag(
        'build',
        abbr: 'b',
        defaultsTo: true,
        help:
            'Triggers Docker image release compilation and registry upload '
            'prior to deployment.',
      );
  }

  @override
  void run() {
    print('Command deploy initiated. Args parsed: ${argResults?.options}');
  }
}
