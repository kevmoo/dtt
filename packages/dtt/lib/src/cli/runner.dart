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
import 'commands/deploy.dart';
import 'commands/dev.dart';
import 'commands/generate.dart';
import 'commands/init.dart';
import 'commands/trigger.dart';

class DttCommandRunner extends CommandRunner<void> {
  DttCommandRunner()
    : super(
        'dtt',
        'A developer-centric CLI tool and orchestrator designed to make '
            'it effortless to deploy serverless Dart Cloud Run services '
            'triggered by Eventarc.',
      ) {
    addCommand(InitCommand());
    addCommand(TriggerCommand());
    addCommand(GenerateCommand());
    addCommand(DeployCommand());
    addCommand(DevCommand());
  }
}
