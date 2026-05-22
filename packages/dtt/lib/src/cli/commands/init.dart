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

class InitCommand extends Command<void> {
  @override
  final String name = 'init';

  @override
  final String description =
      'Initialize the local microservice workspace and scaffold standard '
      'dtt.yaml configurations.';

  InitCommand() {
    argParser
      ..addOption(
        'project-id',
        abbr: 'p',
        help: 'Target Google Cloud Platform (GCP) Project ID.',
      )
      ..addOption(
        'service-name',
        abbr: 's',
        help: 'Name of the serverless Cloud Run service.',
        defaultsTo: 'dtt-service',
      )
      ..addOption(
        'region',
        abbr: 'r',
        help: 'Target GCP region for resource deployment.',
        defaultsTo: 'us-central1',
      );
  }

  @override
  void run() {
    print('Command init initiated. Args parsed: ${argResults?.options}');
  }
}
