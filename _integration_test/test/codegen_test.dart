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
        // 1. Setup a clean package sandbox directory declaratively!
        await d.dir('my_package', [
          d.file('dtt.yaml', '''
service:
  name: firebase-auth-triggers
  project_id: n26-full-stack-dart
  region: us-central1

triggers:
  - name: auth-user-created
    type: google.firebase.auth.user.v2.created
    path: /events/auth
    handler: onUserCreated
'''),
        ]).create();

        final workspacePath = d.sandbox;
        final packagePath = p.join(workspacePath, 'my_package');

        // 2. Invoke the core generator engine
        final generator = DttGenerator(
          workspaceRoot: workspacePath,
          packageDir: packagePath,
        );
        await generator.generateAll();

        // 3. Assert generated serverless entrypoint bin/server.dart is pristine
        final serverFile = File(p.join(packagePath, 'bin', 'server.dart'));
        check(await serverFile.exists()).isTrue();

        final serverContent = await serverFile.readAsString();
        check(serverContent).contains(
          "import 'package:google_cloud_events/google_cloud_events.dart';",
        );
        check(serverContent).contains(
          "import 'package:my_package/src/handlers/on_user_created.dart';",
        );
        check(serverContent).contains('void main() async {');
        check(serverContent).contains('await serveHandler(pipeline);');

        // 4. Assert generated Main Terraform manifest is pristine
        final mainTfFile = File(p.join(workspacePath, 'terraform', 'main.tf'));
        check(await mainTfFile.exists()).isTrue();

        final mainTfContent = await mainTfFile.readAsString();
        check(mainTfContent).contains('data "google_project" "project" {');
        check(
          mainTfContent,
        ).contains('data "google_cloud_run_v2_service" "service"');
        check(
          mainTfContent,
        ).contains('resource "null_resource" "cloud_run_deploy"');
        check(
          mainTfContent,
        ).contains('resource "google_service_account" "eventarc_invoker"');
        check(
          mainTfContent,
        ).contains('name     = data.google_cloud_run_v2_service.service.name');
        check(mainTfContent).contains(
          'resource "google_eventarc_trigger" "trigger_auth-user-created"',
        );
        check(mainTfContent).contains('provider        = google-beta');
        check(
          mainTfContent,
        ).contains('service = data.google_cloud_run_v2_service.service.name');
        check(
          mainTfContent,
        ).contains('value     = "google.firebase.auth.user.v2.created"');
        check(mainTfContent).contains('path    = "/events/auth"');

        // 5. Assert generated Variables Terraform manifest is pristine
        final varsTfFile = File(
          p.join(workspacePath, 'terraform', 'variables.tf'),
        );
        check(await varsTfFile.exists()).isTrue();

        final varsTfContent = await varsTfFile.readAsString();
        check(varsTfContent).contains('default     = "n26-full-stack-dart"');

        // 6. Assert generated Outputs Terraform manifest is pristine
        final outputsTfFile = File(
          p.join(workspacePath, 'terraform', 'outputs.tf'),
        );
        check(await outputsTfFile.exists()).isTrue();

        final outputsTfContent = await outputsTfFile.readAsString();
        check(outputsTfContent).contains(
          'value       = data.google_cloud_run_v2_service.service.uri',
        );
      },
    );

    test(
      'Custom Path Override generates path argument in server.dart',
      () async {
        // 1. Setup clean sandbox directory declaratively!
        await d.dir('custom_package', [
          d.file('dtt.yaml', '''
service:
  name: firebase-auth-triggers
  project_id: n26-full-stack-dart
  region: us-central1

triggers:
  - name: auth-user-created
    type: google.firebase.auth.user.v2.created
    path: /events/my-custom-endpoint
    handler: onUserCreated
'''),
        ]).create();

        final workspacePath = d.sandbox;
        final packagePath = p.join(workspacePath, 'custom_package');

        final generator = DttGenerator(
          workspaceRoot: workspacePath,
          packageDir: packagePath,
        );
        await generator.generateAll();

        final serverFile = File(p.join(packagePath, 'bin', 'server.dart'));
        check(await serverFile.exists()).isTrue();

        final serverContent = await serverFile.readAsString();
        check(
          serverContent,
        ).contains('CloudEventTrigger.firebaseAuthUserCreated');
        check(serverContent).contains("path: '/events/my-custom-endpoint'");
        check(serverContent).contains('handler: onUserCreated');
      },
    );

    test(
      'Cloud Firestore trigger generates dynamic database and document filters',
      () async {
        // 1. Setup clean sandbox directory declaratively!
        await d.dir('firestore_package', [
          d.file('dtt.yaml', '''
service:
  name: firestore-triggers
  project_id: n26-full-stack-dart
  region: us-central1

triggers:
  - name: user-written
    type: google.cloud.firestore.document.v1.written
    path: /events/users
    handler: onUserWritten
    database: "(default)"
    document: "documents/users/{userId}"
'''),
        ]).create();

        final workspacePath = d.sandbox;
        final packagePath = p.join(workspacePath, 'firestore_package');

        // 2. Invoke the core generator engine
        final generator = DttGenerator(
          workspaceRoot: workspacePath,
          packageDir: packagePath,
        );
        await generator.generateAll();

        // 3. Assert generated serverless entrypoint bin/server.dart is pristine
        final serverFile = File(p.join(packagePath, 'bin', 'server.dart'));
        check(await serverFile.exists()).isTrue();

        final serverContent = await serverFile.readAsString();
        check(
          serverContent,
        ).contains('CloudEventTrigger.firestoreDocumentWritten');
        check(serverContent).contains("path: '/events/users'");
        check(serverContent).contains('handler: onUserWritten');

        // 4. Assert generated Main Terraform manifest contains all Firestore
        //    filters
        final mainTfFile = File(p.join(workspacePath, 'terraform', 'main.tf'));
        check(await mainTfFile.exists()).isTrue();

        final mainTfContent = await mainTfFile.readAsString();
        check(mainTfContent).contains('data "google_project" "project" {');
        check(
          mainTfContent,
        ).contains('resource "google_eventarc_trigger" "trigger_user-written"');
        check(
          mainTfContent,
        ).contains('value     = "google.cloud.firestore.document.v1.written"');
        check(mainTfContent).contains('attribute = "database"');
        check(mainTfContent).contains('value     = "(default)"');
        check(mainTfContent).contains('attribute = "document"');
        check(mainTfContent).contains('value     = "documents/users/{userId}"');
        check(mainTfContent).contains(
          'resource "google_project_iam_member" "firestore_pubsub_publisher"',
        );
        check(mainTfContent).contains(
          'resource "google_project_iam_audit_config" "all_services_audit"',
        );
        check(mainTfContent).contains('service = "allServices"');
        check(mainTfContent).contains('log_type = "DATA_WRITE"');
        check(mainTfContent).contains('log_type = "DATA_READ"');
      },
    );
  });
}
