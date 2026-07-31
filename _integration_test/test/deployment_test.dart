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

import 'package:checks/checks.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('Declarative Infrastructure & Build Pipeline E2E Integration Tests', () {
    final rootDir = p.canonicalize(p.join(Directory.current.path, '..'));
    final exampleDir = p.join(rootDir, 'examples', 'firebase_auth_example');
    final tfDir = p.join(rootDir, 'terraform');

    test(
      'Full lifecycle: dtt generate -> dtt build -> dtt deploy -> plan zero drift -> terraform destroy',
      () async {
        // 1. Ensure env access token for GCP calls
        final env = Map<String, String>.from(Platform.environment);
        final adcTokenRes = await Process.run('gcloud', [
          'auth',
          'application-default',
          'print-access-token',
        ]);
        if (adcTokenRes.exitCode == 0) {
          final token = (adcTokenRes.stdout as String).trim();
          if (token.isNotEmpty) {
            env['CLOUDSDK_AUTH_ACCESS_TOKEN'] = token;
            env['GOOGLE_OAUTH_ACCESS_TOKEN'] = token;
          }
        }

        // 2. Run dtt generate
        print('1. Running dtt generate...');
        final genRes = await Process.run(
          'dart',
          [
            'run',
            'packages/dtt/bin/dtt.dart',
            'generate',
            '--package-dir=$exampleDir',
          ],
          workingDirectory: rootDir,
          environment: env,
        );
        check(genRes.exitCode).equals(0);

        // Verify declarative main.tf contains no null_resource
        final mainTfFile = File(p.join(tfDir, 'main.tf'));
        check(await mainTfFile.exists()).isTrue();
        final mainTfContent = await mainTfFile.readAsString();
        check(
          mainTfContent,
        ).contains('resource "google_cloud_run_v2_service" "service"');
        check(mainTfContent).not((c) => c.contains('null_resource'));

        // 3. Run dtt build
        print('2. Running dtt build...');
        final buildRes = await Process.run(
          'dart',
          [
            'run',
            'packages/dtt/bin/dtt.dart',
            'build',
            '--package-dir=$exampleDir',
          ],
          workingDirectory: rootDir,
          environment: env,
        );
        check(buildRes.exitCode).equals(0);

        // Verify build_state.json exists
        final stateFile = File(p.join(exampleDir, '.dtt', 'build_state.json'));
        check(await stateFile.exists()).isTrue();
        final stateContent = await stateFile.readAsString();
        final stateJson = jsonDecode(stateContent) as Map<String, dynamic>;
        final containerImage = stateJson['full_image_digest'] as String;
        check(containerImage).contains('sha256:');

        // 4. Run dtt deploy
        print('3. Running dtt deploy...');
        final deployRes = await Process.run(
          'dart',
          [
            'run',
            'packages/dtt/bin/dtt.dart',
            'deploy',
            '--package-dir=$exampleDir',
          ],
          workingDirectory: rootDir,
          environment: env,
        );
        check(deployRes.exitCode).equals(0);

        try {
          // 5. Run terraform plan to verify zero drift
          print('4. Running terraform plan for drift detection...');
          final planRes = await Process.run(
            'terraform',
            [
              'plan',
              '-lock=false',
              '-var=project_id=dtt-pkg-test',
              '-var=region=us-central1',
              '-var=container_image=$containerImage',
            ],
            workingDirectory: tfDir,
            environment: env,
          );

          check(planRes.exitCode).equals(0);
          check(planRes.stdout as String).contains(
            'No changes. Your infrastructure matches the configuration.',
          );
        } finally {
          // 6. Run terraform destroy to clean up all GCP resources
          print('5. Running terraform destroy for full zero-leak cleanup...');
          final destroyRes = await Process.run(
            'terraform',
            [
              'destroy',
              '-auto-approve',
              '-var=project_id=dtt-pkg-test',
              '-var=region=us-central1',
              '-var=container_image=$containerImage',
            ],
            workingDirectory: tfDir,
            environment: env,
          );

          check(destroyRes.exitCode).equals(0);
          print('✅ Lifecycle test completed successfully with zero leaks!');
        }
      },
      timeout: const Timeout(Duration(minutes: 10)),
    );
  });
}
