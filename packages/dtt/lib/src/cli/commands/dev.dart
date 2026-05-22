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

class DevCommand extends Command<void> {
  @override
  final String name = 'dev';

  @override
  final String description =
      'Internal developer and maintainer system tool utilities (hidden).';

  @override
  // Excludes command listing from standard user-facing --help panels
  final bool hidden = true;

  DevCommand() {
    addSubcommand(CompileCatalogCommand());
  }
}

class CompileCatalogCommand extends Command<void> {
  @override
  final String name = 'compile-catalog';

  @override
  final String description =
      'Compile 100% of the official Google CloudEvents Protobuf '
      'schemas recursively into package:google_cloud_events.';

  CompileCatalogCommand() {
    argParser.addOption(
      'source',
      abbr: 's',
      mandatory: true,
      help:
          'Path to local clone of googleapis/google-cloudevents '
          'repository.',
    );
  }

  @override
  void run() {
    final source = argResults?['source'];
    print('Command dev compile-catalog initiated. Source: $source');
  }
}
