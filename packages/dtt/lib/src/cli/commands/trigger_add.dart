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

class TriggerAddCommand extends Command<void> {
  @override
  final String name = 'add';

  @override
  final String description =
      'Add a new Eventarc trigger mapping to the workspace dtt.yaml '
      'and resolve models.';

  TriggerAddCommand() {
    argParser
      ..addOption(
        'type',
        abbr: 't',
        mandatory: true,
        help:
            'GCP Eventarc target event type '
            '(e.g. google.cloud.storage.object.v1.finalized).',
      )
      ..addOption(
        'handler',
        abbr: 's', // Using 's' to represent handler stub naming reference
        mandatory: true,
        help:
            'Developer callback handler callback function name '
            '(e.g. onStorageUpload).',
      )
      ..addOption(
        'path',
        abbr: 'p',
        help:
            'HTTP route request pathway. Auto-derived from trigger type '
            'if omitted.',
      )
      ..addOption(
        'resource',
        abbr: 'r',
        help:
            'GCP resource identifier path filter '
            '(e.g. projects/_/buckets/my-bucket).',
      )
      ..addOption(
        'provider',
        help:
            'GCP event provider source signature '
            '(e.g. storage.googleapis.com).',
      );
  }

  @override
  void run() {
    print('Command trigger add initiated. Args parsed: ${argResults?.options}');
  }
}
