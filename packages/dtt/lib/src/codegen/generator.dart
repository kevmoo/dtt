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

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../hcl/hcl_writer.dart';

/// Mapping metadata tracking trigger types, import URIs, and class definitions.
class TriggerTypeMeta {
  final String importPath;
  final String className;
  final String enumName;
  final String defaultPath;

  const TriggerTypeMeta({
    required this.importPath,
    required this.className,
    required this.enumName,
    required this.defaultPath,
  });
}

/// Dynamic catalog mapping GCP Eventarc types to pre-compiled model schemas.
const Map<String, TriggerTypeMeta> _typeCatalog = {
  'google.cloud.storage.object.v1.finalized': TriggerTypeMeta(
    importPath:
        'package:google_cloud_events/google/events/cloud/storage/v1/data.pb.dart',
    className: 'StorageObjectData',
    enumName: 'CloudEventTrigger.gcsObjectFinalized',
    defaultPath: '/events/uploads',
  ),
  'google.firebase.auth.user.v1.created': TriggerTypeMeta(
    importPath:
        'package:google_cloud_events/google/events/firebase/auth/v1/data.pb.dart',
    className: 'AuthEventData',
    enumName: 'CloudEventTrigger.firebaseAuthUserCreated',
    defaultPath: '/events/auth',
  ),
};

/// Orchestrates code-generation, outputting server entrypoints, distroless AOT
/// Dockerfiles, and zero-trust regional Terraform manifests natively.
class DttGenerator {
  final String workspaceRoot;
  final String packageDir;

  DttGenerator({required this.workspaceRoot, required this.packageDir});

  /// Runs all sub-generators, creating/updating target files in the workspace.
  Future<void> generateAll() async {
    final configFile = File(p.join(packageDir, 'dtt.yaml'));
    if (!await configFile.exists()) {
      throw FileSystemException(
        'Declarative config dtt.yaml not found inside target folder.',
        configFile.path,
      );
    }

    final content = await configFile.readAsString();
    final doc = loadYaml(content) as YamlMap;

    final serviceNode = doc['service'] as YamlMap?;
    if (serviceNode == null) {
      throw const FormatException(
        'Config missing mandatory [service] mapping block.',
      );
    }

    final serviceName = serviceNode['name'] as String? ?? 'dtt-service';
    final projectId = serviceNode['project_id'] as String? ?? 'gcp-project-id';
    final region = serviceNode['region'] as String? ?? 'us-central1';

    final triggersNode = doc['triggers'] as YamlList?;
    if (triggersNode == null || triggersNode.isEmpty) {
      throw const FormatException(
        'Config missing [triggers] declarations list.',
      );
    }

    final triggers = <Map<String, String>>[];
    for (final node in triggersNode) {
      if (node case {
        'name': final String name,
        'type': final String type,
        'path': final String path,
        'handler': final String handler,
      }) {
        triggers.add({
          'name': name,
          'type': type,
          'path': path,
          'handler': handler,
        });
      } else {
        throw const FormatException(
          'Trigger mappings must specify name, type, path, and handler '
          'callbacks.',
        );
      }
    }

    // 1. Generate the server entrypoint inside package bin/
    await _generateServer(serviceName, triggers);

    // 2. Generate secure regional Terraform manifests at root
    await _generateTerraform(serviceName, projectId, region, triggers);
  }

  Future<void> _generateServer(
    String serviceName,
    List<Map<String, String>> triggers,
  ) async {
    final binDir = Directory(p.join(packageDir, 'bin'));
    if (!await binDir.exists()) {
      await binDir.create(recursive: true);
    }

    final imports = <String>{
      "import 'package:dtt_runtime/cloudevents.dart';",
      "import 'package:google_cloud_events/google_cloud_events.dart';",
      "import 'package:google_cloud_shelf/google_cloud_shelf.dart';",
      "import 'package:shelf/shelf.dart';",
    };
    final registrations = <String>[];

    final packageName = p.basename(packageDir);

    for (final trigger in triggers) {
      final type = trigger['type']!;
      final meta = _typeCatalog[type];
      if (meta == null) {
        throw UnsupportedError(
          'Target Eventarc trigger type [$type] is not registered in '
          'schemas catalog.',
        );
      }

      final handler = trigger['handler']!;
      // Import the developer's callback function under standard package syntax
      imports.add(
        "import 'package:$packageName/src/handlers/"
        "${_camelToSnake(handler)}.dart';",
      );

      final path = trigger['path']!;
      final enumName = meta.enumName;
      final defaultPath = meta.defaultPath;

      // If custom path differs from trigger defaultPath, generate override
      final pathArg = path != defaultPath ? '\n      path: \'$path\',' : '';

      registrations.add('''
    ..registerTrigger(
      trigger: $enumName,$pathArg
      handler: $handler,
    )''');
    }

    final sortedImports = imports.toList()..sort();

    final buffer = StringBuffer()
      ..writeln('// This is an auto-generated file - DO NOT EDIT.')
      ..writeln('// Generated by dtt code generator tool.')
      ..writeln();

    for (final imp in sortedImports) {
      buffer.writeln(imp);
    }

    buffer
      ..writeln()
      ..writeln('void main() async {')
      ..writeln('  final router = DttEventRouter()')
      ..write(registrations.join(';\n'))
      ..writeln(';')
      ..writeln()
      ..writeln('  final pipeline = const Pipeline()')
      ..writeln('      .addMiddleware(logRequests())')
      ..writeln('      .addHandler(router.handle);')
      ..writeln()
      ..writeln('  await serveHandler(pipeline);')
      ..writeln('}');

    final serverFile = File(p.join(binDir.path, 'server.dart'));
    await serverFile.writeAsString(buffer.toString());
  }

  Future<void> _generateTerraform(
    final String serviceName,
    final String projectId,
    final String region,
    final List<Map<String, String>> triggers,
  ) async {
    final tfDir = Directory(p.join(workspaceRoot, 'terraform'));
    if (!await tfDir.exists()) {
      await tfDir.create(recursive: true);
    }

    // 1. Synthesize terraform/main.tf using the HCL Writer DSL!
    final mainFile = HclFile();

    // Block 1: Terraform config block
    final tfConfig = HclBlock(type: 'terraform')
      ..attribute('required_version', const HclValue.string('>= 1.3.0'))
      ..addBlock(
        HclBlock(type: 'required_providers')..addBlock(
          HclBlock(type: 'google')
            ..attribute('source', const HclValue.string('hashicorp/google'))
            ..attribute('version', const HclValue.string('>= 5.0.0')),
        ),
      );
    mainFile.addBlock(tfConfig);

    // Block 2: Provider google block
    final provider =
        HclBlock(type: 'provider', labels: const <String>['google'])
          ..attribute('project', const HclValue.raw('var.project_id'))
          ..attribute('region', const HclValue.raw('var.region'));
    mainFile.addBlock(provider);

    // Block 3: Zip archiver data source
    final archiveData =
        HclBlock(
            type: 'data',
            labels: const <String>['archive_file', 'source_zip'],
          )
          ..comment(
            'Natively compresses the local workspace source directories '
            'automatically!',
          )
          ..attribute('type', const HclValue.string('zip'))
          ..attribute('source_dir', const HclValue.string('\${path.module}/..'))
          ..attribute(
            'output_path',
            const HclValue.string('\${path.module}/source.zip'),
          )
          ..attribute(
            'excludes',
            const HclValue.list(<HclValue>[
              HclValue.string('.dart_tool'),
              HclValue.string('.git'),
              HclValue.string('build'),
              HclValue.string('terraform'),
              HclValue.string('docs'),
            ]),
          );
    mainFile.addBlock(archiveData);

    // Block 4: Private GCS sources bucket
    final bucket =
        HclBlock(
            type: 'resource',
            labels: const <String>['google_storage_bucket', 'sources'],
          )
          ..comment(
            'Secure private GCS bucket storing transient code zip archives',
          )
          ..attribute(
            'name',
            const HclValue.string('\${var.project_id}-dtt-sources'),
          )
          ..attribute('location', const HclValue.raw('var.region'))
          ..attribute('force_destroy', const HclValue.boolean(true));
    mainFile.addBlock(bucket);

    // Block 5: Zip object uploader resource
    final uploadObject =
        HclBlock(
            type: 'resource',
            labels: const <String>['google_storage_bucket_object', 'archive'],
          )
          ..comment(
            'Uploads the compressed local workspace zip file straight to GCS',
          )
          ..attribute(
            'name',
            const HclValue.string(
              'source-\${data.archive_file.source_zip.output_md5}.zip',
            ),
          )
          ..attribute(
            'bucket',
            const HclValue.raw('google_storage_bucket.sources.name'),
          )
          ..attribute(
            'source',
            const HclValue.raw('data.archive_file.source_zip.output_path'),
          );
    mainFile.addBlock(uploadObject);

    // Block 6: Google Cloud Run Service with build_config
    final service =
        HclBlock(
            type: 'resource',
            labels: const <String>['google_cloud_run_v2_service', 'service'],
          )
          ..comment('Google Cloud Run Service with native buildpack builds!')
          ..attribute('name', HclValue.string(serviceName))
          ..attribute('location', const HclValue.raw('var.region'))
          ..attribute(
            'ingress',
            const HclValue.string('INGRESS_TRAFFIC_INTERNAL_ONLY'),
          );

    // Nested blocks under Cloud Run service template definition
    final ports = HclBlock(type: 'ports')
      ..attribute('container_port', const HclValue.number(8080));

    final limits = HclBlock(type: 'limits')
      ..attribute('cpu', const HclValue.string('1'))
      ..attribute('memory', const HclValue.string('512Mi'));

    final resources = HclBlock(type: 'resources')..addBlock(limits);

    final containers = HclBlock(type: 'containers')
      ..attribute(
        'image',
        HclValue.string(
          'us-central1-docker.pkg.dev/\${var.project_id}/'
          'cloud-run-images/$serviceName:latest',
        ),
      )
      ..addBlock(ports)
      ..addBlock(resources);

    final template = HclBlock(type: 'template')..addBlock(containers);

    // Dynamic build configuration block compiling from GCS!
    final storageSource = HclBlock(type: 'storage_source')
      ..attribute(
        'bucket',
        const HclValue.raw('google_storage_bucket.sources.name'),
      )
      ..attribute(
        'object',
        const HclValue.raw('google_storage_bucket_object.archive.name'),
      );

    final sourcePackage = HclBlock(type: 'source_package')
      ..addBlock(storageSource);

    final buildConfig = HclBlock(type: 'build_config')
      ..attribute(
        'image_uri',
        HclValue.string(
          'us-central1-docker.pkg.dev/\${var.project_id}/'
          'cloud-run-images/$serviceName:latest',
        ),
      )
      ..addBlock(sourcePackage);

    service
      ..addBlock(template)
      ..addBlock(buildConfig);
    mainFile.addBlock(service);

    // Block 7: Zero-Trust minimum privilege service account mapping
    final serviceAccount =
        HclBlock(
            type: 'resource',
            labels: const <String>[
              'google_service_account',
              'eventarc_invoker',
            ],
          )
          ..comment('Zero-Trust minimum privilege service account mapping')
          ..attribute(
            'account_id',
            HclValue.string('eventarc-$serviceName-invoker'),
          )
          ..attribute(
            'display_name',
            HclValue.string('Eventarc $serviceName Invoker Service Account'),
          );
    mainFile.addBlock(serviceAccount);

    // Block 8: Grant Invoker Service Account authorization to call Cloud Run
    final iamMember =
        HclBlock(
            type: 'resource',
            labels: const <String>[
              'google_cloud_run_v2_service_iam_member',
              'invoker_role',
            ],
          )
          ..comment(
            'Grant Invoker Service Account authorization to call our '
            'Cloud Run container',
          )
          ..attribute(
            'name',
            const HclValue.raw('google_cloud_run_v2_service.service.name'),
          )
          ..attribute(
            'location',
            const HclValue.raw('google_cloud_run_v2_service.service.location'),
          )
          ..attribute('role', const HclValue.string('roles/run.invoker'))
          ..attribute(
            'member',
            const HclValue.string(
              'serviceAccount:'
              r'${google_service_account.eventarc_invoker.email}',
            ),
          );
    mainFile.addBlock(iamMember);

    // Block 9: Bind Eventarc Receiver permissions to service agent profiles
    final iamReceiver =
        HclBlock(
            type: 'resource',
            labels: const <String>[
              'google_project_iam_member',
              'eventarc_receiver',
            ],
          )
          ..comment(
            'Bind Eventarc Receiver permissions to standard GCP service '
            'agent profiles',
          )
          ..attribute('project', const HclValue.raw('var.project_id'))
          ..attribute(
            'role',
            const HclValue.string('roles/eventarc.eventReceiver'),
          )
          ..attribute(
            'member',
            const HclValue.string(
              'serviceAccount:'
              r'${google_service_account.eventarc_invoker.email}',
            ),
          );
    mainFile.addBlock(iamReceiver);

    // Block 10: Dynamically append Google Eventarc trigger resource blocks
    for (final trigger in triggers) {
      final name = trigger['name']!;
      final type = trigger['type']!;
      final path = trigger['path']!;

      final triggerBlock =
          HclBlock(
              type: 'resource',
              labels: <String>['google_eventarc_trigger', 'trigger_$name'],
            )
            ..comment('GCP Eventarc Trigger Mapping signals: $name')
            ..attribute('name', HclValue.string('$serviceName-$name-trigger'))
            ..attribute('location', const HclValue.raw('var.region'))
            ..attribute(
              'service_account',
              const HclValue.raw(
                'google_service_account.eventarc_invoker.email',
              ),
            );

      final cloudRunService = HclBlock(type: 'cloud_run_service')
        ..attribute(
          'service',
          const HclValue.raw('google_cloud_run_v2_service.service.name'),
        )
        ..attribute('region', const HclValue.raw('var.region'))
        ..attribute('path', HclValue.string(path));

      final destination = HclBlock(type: 'destination')
        ..addBlock(cloudRunService);

      final criteria = HclBlock(type: 'matching_criteria')
        ..attribute('attribute', const HclValue.string('type'))
        ..attribute('value', HclValue.string(type));

      triggerBlock
        ..addBlock(destination)
        ..addBlock(criteria);
      mainFile.addBlock(triggerBlock);
    }

    final mainTf = File(p.join(tfDir.path, 'main.tf'));
    await mainTf.writeAsString(mainFile.toString());

    // 2. Synthesize terraform/variables.tf using the HCL Writer DSL!
    final variablesFile = HclFile();

    final varProjectId =
        HclBlock(type: 'variable', labels: const <String>['project_id'])
          ..attribute('type', const HclValue.raw('string'))
          ..attribute(
            'description',
            const HclValue.string('Target Google Cloud Platform Project ID.'),
          )
          ..attribute('default', HclValue.string(projectId));
    variablesFile.addBlock(varProjectId);

    final varRegion =
        HclBlock(type: 'variable', labels: const <String>['region'])
          ..attribute('type', const HclValue.raw('string'))
          ..attribute(
            'description',
            const HclValue.string(
              'Target GCP region for resources deployment.',
            ),
          )
          ..attribute('default', HclValue.string(region));
    variablesFile.addBlock(varRegion);

    final variablesTf = File(p.join(tfDir.path, 'variables.tf'));
    await variablesTf.writeAsString(variablesFile.toString());

    // 3. Synthesize terraform/outputs.tf using the HCL Writer DSL!
    final outputsFile = HclFile();

    final outputUrl =
        HclBlock(type: 'output', labels: const <String>['service_url'])
          ..attribute(
            'value',
            const HclValue.raw('google_cloud_run_v2_service.service.uri'),
          )
          ..attribute(
            'description',
            const HclValue.string(
              'URL of our deployed serverless Dart Cloud Run service '
              'container.',
            ),
          );
    outputsFile.addBlock(outputUrl);

    final outputTriggers =
        HclBlock(type: 'output', labels: const <String>['eventarc_trigger_ids'])
          ..attribute(
            'value',
            const HclValue.raw(
              '[\n    for t in google_eventarc_trigger.trigger_* : t.id\n  ]',
            ),
          )
          ..attribute(
            'description',
            const HclValue.string(
              'Resource identifiers tracking active Eventarc triggers.',
            ),
          );
    outputsFile.addBlock(outputTriggers);

    final outputsTf = File(p.join(tfDir.path, 'outputs.tf'));
    await outputsTf.writeAsString(outputsFile.toString());
  }
}

String _camelToSnake(String input) => input
    .replaceAllMapped(
      RegExp(r'(.)([A-Z])'),
      (Match match) => '${match.group(1)}_${match.group(2)}',
    )
    .toLowerCase();
