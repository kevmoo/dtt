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

import 'package:checks/checks.dart';
import 'package:dtt/src/codegen/generator.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

void main() {
  group('DttGenerator Codebase and Manifests Orchestration Tests', () {
    test(
      'Natively parses dtt.yaml and string-interpolates all E2E assets',
      () async {
        final workspacePath = d.sandbox;
        final packagePath = p.join(workspacePath, 'my_package');

        // 1. Setup a clean package sandbox directory
        await Directory(packagePath).create(recursive: true);

        // 2. Write custom declarative config mapping n26-full-stack-dart
        final dttYaml = File(p.join(packagePath, 'dtt.yaml'));
        await dttYaml.writeAsString('''
service:
  name: firebase-auth-triggers
  project_id: n26-full-stack-dart
  region: us-central1

triggers:
  - name: auth-user-created
    type: google.firebase.auth.user.v1.created
    path: /events/auth
    handler: onUserCreated
''');

        // 3. Invoke the core generator engine
        final generator = DttGenerator(
          workspaceRoot: workspacePath,
          packageDir: packagePath,
        );
        await generator.generateAll();

        // 4. Assert generated serverless entrypoint bin/server.dart is pristine
        final serverFile = File(p.join(packagePath, 'bin', 'server.dart'));
        check(await serverFile.exists()).isTrue();

        final serverContent = await serverFile.readAsString();
        check(serverContent).contains(
          "import 'package:google_cloud_events/google_cloud_events.dart';",
        );
        check(serverContent).contains(
          "import 'package:my_package/src/handlers/on_user_created.dart';",
        );
        check(serverContent).contains('''
    ..registerTrigger(
      trigger: CloudEventTrigger.firebaseAuthUserCreated,
      handler: onUserCreated,
    )''');

        // 5. Assert generated Main Terraform manifest is pristine
        final mainTfFile = File(p.join(workspacePath, 'terraform', 'main.tf'));
        check(await mainTfFile.exists()).isTrue();

        final mainTfContent = await mainTfFile.readAsString();
        check(
          mainTfContent,
        ).contains('resource "google_cloud_run_v2_service" "service"');
        check(mainTfContent).contains('name     = "firebase-auth-triggers"');
        check(mainTfContent).contains(
          'image = "us-central1-docker.pkg.dev/\${var.project_id}/cloud-run-images/firebase-auth-triggers:latest"',
        );
        check(mainTfContent).contains('build_config {');
        check(mainTfContent).contains('source_package {');
        check(mainTfContent).contains('storage_source {');
        check(
          mainTfContent,
        ).contains('bucket = google_storage_bucket.sources.name');
        check(
          mainTfContent,
        ).contains('object = google_storage_bucket_object.archive.name');
        check(
          mainTfContent,
        ).contains('resource "google_service_account" "eventarc_invoker"');
        check(mainTfContent).contains(
          'resource "google_eventarc_trigger" "trigger_auth-user-created"',
        );
        check(
          mainTfContent,
        ).contains('value     = "google.firebase.auth.user.v1.created"');
        check(mainTfContent).contains('path    = "/events/auth"');

        // 7. Assert generated Variables Terraform manifest is pristine
        final varsTfFile = File(
          p.join(workspacePath, 'terraform', 'variables.tf'),
        );
        check(await varsTfFile.exists()).isTrue();

        final varsTfContent = await varsTfFile.readAsString();
        check(varsTfContent).contains('default     = "n26-full-stack-dart"');

        // 8. Assert generated Outputs Terraform manifest is pristine
        final outputsTfFile = File(
          p.join(workspacePath, 'terraform', 'outputs.tf'),
        );
        check(await outputsTfFile.exists()).isTrue();

        final outputsTfContent = await outputsTfFile.readAsString();
        check(
          outputsTfContent,
        ).contains('value       = google_cloud_run_v2_service.service.uri');
      },
    );

    test(
      'Custom Path Override generates path argument in server.dart',
      () async {
        final workspacePath = d.sandbox;
        final packagePath = p.join(workspacePath, 'custom_package');
        await Directory(packagePath).create(recursive: true);

        final dttYaml = File(p.join(packagePath, 'dtt.yaml'));
        await dttYaml.writeAsString('''
service:
  name: firebase-auth-triggers
  project_id: n26-full-stack-dart
  region: us-central1

triggers:
  - name: auth-user-created
    type: google.firebase.auth.user.v1.created
    path: /events/my-custom-endpoint
    handler: onUserCreated
''');

        final generator = DttGenerator(
          workspaceRoot: workspacePath,
          packageDir: packagePath,
        );
        await generator.generateAll();

        final serverFile = File(p.join(packagePath, 'bin', 'server.dart'));
        check(await serverFile.exists()).isTrue();

        final serverContent = await serverFile.readAsString();
        check(serverContent).contains('''
    ..registerTrigger(
      trigger: CloudEventTrigger.firebaseAuthUserCreated,
      path: '/events/my-custom-endpoint',
      handler: onUserCreated,
    )''');
      },
    );
  });
}
