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

import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../hcl/hcl_writer.dart';
import 'trigger_config.dart';

/// Orchestrates code-generation, outputting server entrypoints, distroless AOT
/// Dockerfiles, and zero-trust regional Terraform manifests natively.
Future<void> generateProject({
  required String workspaceRoot,
  required String packageDir,
}) => _DttGenerator(
  workspaceRoot: workspaceRoot,
  packageDir: packageDir,
).generateAll();

class _DttGenerator {
  final String workspaceRoot;
  final String packageDir;

  _DttGenerator({required this.workspaceRoot, required this.packageDir});

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

    final triggers = <TriggerConfig>[];
    for (final node in triggersNode) {
      if (node is YamlMap) {
        triggers.add(TriggerConfig.fromYaml(node));
      } else {
        throw const FormatException(
          'Trigger mappings must specify name, type, path, and handler '
          'callbacks.',
        );
      }
    }

    // 1. Generate the server entrypoint inside package bin/
    await _generateServer(serviceName, triggers);

    // 2. Generate cross-platform Dart deploy script inside package bin/
    await _generateDeployScript();

    // 3. Generate secure regional Terraform manifests at root
    await _generateTerraform(serviceName, projectId, region, triggers);
  }

  Future<void> _generateServer(
    String serviceName,
    List<TriggerConfig> triggers,
  ) async {
    final binDir = Directory(p.join(packageDir, 'bin'));
    if (!await binDir.exists()) {
      await binDir.create(recursive: true);
    }

    final imports = <String>{
      'package:dtt_runtime/cloudevents.dart',
      'package:google_cloud_events/google_cloud_events.dart',
      'package:google_cloud_shelf/google_cloud_shelf.dart',
      'package:shelf/shelf.dart',
    };

    final packageName = p.basename(packageDir);

    for (final trigger in triggers) {
      final handler = trigger.handler;
      imports.add(
        'package:$packageName/src/handlers/'
        '${_camelToSnake(handler)}.dart',
      );
    }

    // Sort the imports alphabetically to satisfy strict directives ordering
    // lints!
    final sortedImports = imports.toList()..sort();

    // 1. Construct AST method main() using code_builder and CodeExpression!
    final mainMethod = Method(
      (m) => m
        ..name = 'main'
        ..returns = refer('void')
        ..modifier = MethodModifier.async
        ..body = Block((b) {
          // final router = DttEventRouter()..registerTrigger(...);
          final registrations = StringBuffer()..write('DttEventRouter()');

          for (final trigger in triggers) {
            final meta = trigger.meta;
            final handler = trigger.handler;
            final path = trigger.path;
            final enumName = meta.enumName;
            final defaultPath = meta.defaultPath;

            final pathArg = path != defaultPath
                ? '\n      path: \'$path\','
                : '';
            registrations.write('''
    ..registerTrigger(
      trigger: $enumName,$pathArg
      handler: $handler,
    )''');
          }

          final routerVar = declareFinal(
            'router',
          ).assign(CodeExpression(Code(registrations.toString())));
          b.statements.add(routerVar.statement);

          final pipelineVar = declareFinal('pipeline').assign(
            refer('Pipeline')
                .constInstance([])
                .property('addMiddleware')
                .call([refer('logRequests').call([])])
                .property('addHandler')
                .call([refer('router').property('handle')]),
          );
          b.statements.add(pipelineVar.statement);

          // await serveHandler(pipeline);
          final serveCall = refer(
            'serveHandler',
          ).call([refer('pipeline')]).awaited;
          b.statements.add(serveCall.statement);
        }),
    );

    // 2. Construct AST Library container compiling sorted imports directives!
    final library = Library(
      (l) => l
        ..directives.addAll(sortedImports.map(Directive.import))
        ..body.add(mainMethod),
    );

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final rawContent = library.accept(emitter).toString();

    final buffer = StringBuffer()
      ..writeln('// This is an auto-generated file - DO NOT EDIT.')
      ..writeln('// Generated by dtt code generator tool.')
      ..writeln()
      ..writeln(rawContent);

    final serverFile = File(p.join(binDir.path, 'server.dart'));
    await serverFile.writeAsString(buffer.toString());

    // 3. Run the official SDK Dart Formatter on the generated file!
    await Process.run('dart', ['format', serverFile.path]);
  }

  Future<void> _generateDeployScript() async {
    final deployFile = File(p.join(packageDir, 'bin', 'deploy.dart'));
    const content = '''
// Generated by dart_terraform_triggers (dtt). Do not edit.
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.length < 4) {
    stderr.writeln(
      'Usage: deploy.dart <gcloud_path> <service_name> <project_id> <region>',
    );
    exitCode = 64;
    return;
  }
  final gcloudPath = args[0];
  final serviceName = args[1];
  final projectId = args[2];
  final region = args[3];

  final stageDir = Directory.systemTemp.createTempSync('dtt_build_');
  print('📡 Created isolated temporary staging directory: \${stageDir.path}');

  try {
    final binDir = Directory('\${stageDir.path}/bin');
    binDir.createSync(recursive: true);

    print('📦 Running dart pub get...');
    final pubRes = await Process.run('dart', ['pub', 'get']);
    if (pubRes.exitCode != 0) {
      stderr.write(pubRes.stderr);
      throw ProcessException(
        'dart',
        ['pub', 'get'],
        'Failed pub get',
        pubRes.exitCode,
      );
    }

    final exeName = Platform.isWindows ? 'server.exe' : 'server';
    final targetPath = '\${binDir.path}/\$exeName';

    print('🔨 Cross-compiling Dart server to native binary...');
    final compileRes = await Process.run('dart', [
      'compile',
      'exe',
      'bin/server.dart',
      '-o',
      targetPath,
      '--target-os',
      'linux',
      '--target-arch',
      'x64',
    ]);
    if (compileRes.exitCode != 0) {
      stderr.write(compileRes.stderr);
      throw ProcessException(
        'dart',
        ['compile', 'exe'],
        'Compilation failed',
        compileRes.exitCode,
      );
    }

    print('🚀 Deploying compiled staging directory to Cloud Run...');
    final deployRes = await Process.run(gcloudPath, [
      'beta',
      'run',
      'deploy',
      serviceName,
      '--source=\${stageDir.path}',
      '--region=\$region',
      '--ingress=internal',
      '--project=\$projectId',
      '--no-build',
      '--base-image=osonly24',
      '--command=bin/\$exeName',
      '--quiet',
    ]);
    if (deployRes.exitCode != 0) {
      stderr.write(deployRes.stderr);
      throw ProcessException(
        gcloudPath,
        ['beta', 'run', 'deploy'],
        'Deployment failed',
        deployRes.exitCode,
      );
    }
    print(deployRes.stdout);
    print('✅ Service \$serviceName deployed successfully!');
  } finally {
    if (stageDir.existsSync()) {
      stageDir.deleteSync(recursive: true);
    }
  }
}
''';
    await deployFile.writeAsString(content);
    await Process.run('dart', ['format', deployFile.path]);
  }

  Future<void> _generateTerraform(
    final String serviceName,
    final String projectId,
    final String region,
    final List<TriggerConfig> triggers,
  ) async {
    final tfDir = Directory(p.join(workspaceRoot, 'terraform'));
    if (!await tfDir.exists()) {
      await tfDir.create(recursive: true);
    }

    final gcloudPath = _resolveGcloudPath();
    final packageRelPath = p.relative(packageDir, from: workspaceRoot);

    final saSuffix = serviceName.length > 15
        ? serviceName.substring(0, 15)
        : serviceName;
    final saAccountId = 'dtt-$saSuffix-inv';

    // 1. Synthesize terraform/main.tf
    final mainFile = _buildMainTf(
      serviceName: serviceName,
      saAccountId: saAccountId,
      packageRelPath: packageRelPath,
      gcloudPath: gcloudPath,
      triggers: triggers,
    );
    final mainTf = File(p.join(tfDir.path, 'main.tf'));
    await mainTf.writeAsString(mainFile.toString());

    // 2. Synthesize terraform/variables.tf
    final variablesFile = _buildVariablesTf(projectId, region);
    final variablesTf = File(p.join(tfDir.path, 'variables.tf'));
    await variablesTf.writeAsString(variablesFile.toString());

    // 3. Synthesize terraform/outputs.tf
    final outputsFile = _buildOutputsTf(triggers);
    final outputsTf = File(p.join(tfDir.path, 'outputs.tf'));
    await outputsTf.writeAsString(outputsFile.toString());
  }
}

String _resolveGcloudPath() {
  var gcloudPath = 'gcloud';
  try {
    final whichResult = Process.runSync('which', ['gcloud']);
    if (whichResult.exitCode == 0) {
      gcloudPath = whichResult.stdout.toString().trim();
    } else {
      final fallback = File(
        '/Users/kevmoo/.local/share/mise/installs/gcloud/569.0.0/bin/gcloud',
      );
      if (fallback.existsSync()) {
        gcloudPath = fallback.path;
      }
    }
  } catch (_) {}
  return gcloudPath;
}

HclFile _buildVariablesTf(String projectId, String region) {
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

  final varRegion = HclBlock(type: 'variable', labels: const <String>['region'])
    ..attribute('type', const HclValue.raw('string'))
    ..attribute(
      'description',
      const HclValue.string('Target GCP region for resources deployment.'),
    )
    ..attribute('default', HclValue.string(region));
  variablesFile.addBlock(varRegion);

  return variablesFile;
}

HclFile _buildOutputsTf(List<TriggerConfig> triggers) {
  final outputsFile = HclFile();

  final outputUrl =
      HclBlock(type: 'output', labels: const <String>['service_url'])
        ..attribute(
          'value',
          const HclValue.raw('data.google_cloud_run_v2_service.service.uri'),
        )
        ..attribute(
          'description',
          const HclValue.string(
            'URL of our deployed serverless Dart Cloud Run service '
            'container.',
          ),
        );
  outputsFile.addBlock(outputUrl);

  final triggerRefs = <HclValue>[];
  for (final trigger in triggers) {
    final name = trigger.name;
    triggerRefs.add(HclValue.raw('google_eventarc_trigger.trigger_$name.id'));
  }

  final outputTriggers =
      HclBlock(type: 'output', labels: const <String>['eventarc_trigger_ids'])
        ..attribute('value', HclValue.list(triggerRefs))
        ..attribute(
          'description',
          const HclValue.string(
            'Resource identifiers tracking active Eventarc triggers.',
          ),
        );
  outputsFile.addBlock(outputTriggers);

  return outputsFile;
}

HclFile _buildMainTf({
  required String serviceName,
  required String saAccountId,
  required String packageRelPath,
  required String gcloudPath,
  required List<TriggerConfig> triggers,
}) {
  final mainFile = HclFile();

  for (final block in _buildCoreProvidersAndDataSources(serviceName)) {
    mainFile.addBlock(block);
  }

  mainFile.addBlock(
    _buildDeployResource(
      packageRelPath: packageRelPath,
      gcloudPath: gcloudPath,
      serviceName: serviceName,
    ),
  );

  for (final block in _buildServiceAccountAndInvoker(
    saAccountId,
    serviceName,
  )) {
    mainFile.addBlock(block);
  }

  for (final block in _buildServiceAgentIamBlocks(triggers)) {
    mainFile.addBlock(block);
  }

  for (final trigger in triggers) {
    mainFile.addBlock(_buildEventarcTriggerBlock(trigger, serviceName));
  }

  return mainFile;
}

List<HclBlock> _buildCoreProvidersAndDataSources(String serviceName) {
  final tfConfig = HclBlock(type: 'terraform')
    ..attribute('required_version', const HclValue.string('>= 1.3.0'))
    ..addBlock(
      HclBlock(type: 'required_providers')
        ..attribute(
          'google',
          const HclValue.map(<String, HclValue>{
            'source': HclValue.string('hashicorp/google'),
            'version': HclValue.string('>= 5.0.0'),
          }),
        )
        ..attribute(
          'google-beta',
          const HclValue.map(<String, HclValue>{
            'source': HclValue.string('hashicorp/google-beta'),
            'version': HclValue.string('>= 5.0.0'),
          }),
        ),
    );

  final provider = HclBlock(type: 'provider', labels: const <String>['google'])
    ..attribute('project', const HclValue.raw('var.project_id'))
    ..attribute('region', const HclValue.raw('var.region'));

  final providerBeta =
      HclBlock(type: 'provider', labels: const <String>['google-beta'])
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute('region', const HclValue.raw('var.region'));

  final serviceData =
      HclBlock(
          type: 'data',
          labels: const <String>['google_cloud_run_v2_service', 'service'],
        )
        ..comment('Retrieve live metadata of our pre-deployed OS-only service')
        ..attribute('name', HclValue.string(serviceName))
        ..attribute('location', const HclValue.raw('var.region'))
        ..attribute(
          'depends_on',
          const HclValue.list(<HclValue>[
            HclValue.raw('null_resource.cloud_run_deploy'),
          ]),
        );

  final projectData = HclBlock(
    type: 'data',
    labels: const <String>['google_project', 'project'],
  )..comment('Retrieve live project metadata for Service Agent referencing');

  return [tfConfig, provider, providerBeta, serviceData, projectData];
}

HclBlock _buildDeployResource({
  required String packageRelPath,
  required String gcloudPath,
  required String serviceName,
}) =>
    HclBlock(
        type: 'resource',
        labels: const <String>['null_resource', 'cloud_run_deploy'],
      )
      ..comment(
        'E2E Source-Based deployment compiler utilizing Dart helper script '
        'preventing local codebase pollution and ensuring Windows/POSIX support',
      )
      ..attribute(
        'triggers',
        const HclValue.map(<String, HclValue>{
          'config_hash': HclValue.raw(
            r'fileexists("${path.module}/../dtt.yaml") ? '
            r'filesha256("${path.module}/../dtt.yaml") : "default"',
          ),
          'server_hash': HclValue.raw(
            r'fileexists("${path.module}/../bin/server.dart") ? '
            r'filesha256("${path.module}/../bin/server.dart") : "default"',
          ),
          'deploy_hash': HclValue.raw(
            r'fileexists("${path.module}/../bin/deploy.dart") ? '
            r'filesha256("${path.module}/../bin/deploy.dart") : "default"',
          ),
        }),
      )
      ..addBlock(
        HclBlock(type: 'provisioner', labels: const <String>['local-exec'])
          ..attribute(
            'working_dir',
            HclValue.raw('"\${path.module}/../$packageRelPath"'),
          )
          ..attribute(
            'command',
            HclValue.raw(
              '"dart run bin/deploy.dart $gcloudPath $serviceName \${var.project_id} \${var.region}"',
            ),
          ),
      );

List<HclBlock> _buildServiceAccountAndInvoker(
  String saAccountId,
  String serviceName,
) {
  final serviceAccount =
      HclBlock(
          type: 'resource',
          labels: const <String>['google_service_account', 'eventarc_invoker'],
        )
        ..comment('Zero-Trust minimum privilege service account mapping')
        ..attribute('account_id', HclValue.string(saAccountId))
        ..attribute(
          'display_name',
          HclValue.string('Eventarc $serviceName Invoker Service Account'),
        );

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
          const HclValue.raw('data.google_cloud_run_v2_service.service.name'),
        )
        ..attribute(
          'location',
          const HclValue.raw(
            'data.google_cloud_run_v2_service.service.location',
          ),
        )
        ..attribute('role', const HclValue.string('roles/run.invoker'))
        ..attribute(
          'member',
          const HclValue.string(
            'serviceAccount:'
            r'${google_service_account.eventarc_invoker.email}',
          ),
        );

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

  return [serviceAccount, iamMember, iamReceiver];
}

List<HclBlock> _buildServiceAgentIamBlocks(List<TriggerConfig> triggers) {
  final blocks = <HclBlock>[];
  final hasFirestore = triggers.any((t) => t is FirestoreTriggerConfig);
  final hasStorage = triggers.any((t) => t is StorageTriggerConfig);

  if (hasFirestore) {
    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_project_iam_member',
            'firestore_pubsub_publisher',
          ],
        )
        ..comment(
          'Grant Cloud Firestore Service Agent permissions to publish to '
          'transport topics',
        )
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute('role', const HclValue.string('roles/pubsub.publisher'))
        ..attribute(
          'member',
          const HclValue.string(
            'serviceAccount:service-'
            r'${data.google_project.project.number}'
            '@gcp-sa-firestore.iam.gserviceaccount.com',
          ),
        ),
    );

    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_project_iam_audit_config',
            'all_services_audit',
          ],
        )
        ..comment(
          'Enable Project-Wide Data Access Audit Logs for all services to '
          'forward triggers event signals',
        )
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute('service', const HclValue.string('allServices'))
        ..addBlock(
          HclBlock(type: 'audit_log_config')
            ..attribute('log_type', const HclValue.string('DATA_WRITE')),
        )
        ..addBlock(
          HclBlock(type: 'audit_log_config')
            ..attribute('log_type', const HclValue.string('DATA_READ')),
        ),
    );
  }

  if (hasStorage) {
    blocks.add(
      HclBlock(
        type: 'data',
        labels: const <String>[
          'google_storage_project_service_account',
          'gcs_account',
        ],
      ),
    );

    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_project_iam_member',
            'storage_pubsub_publisher',
          ],
        )
        ..comment(
          'Grant Cloud Storage Service Agent permissions to publish to '
          'transport topics',
        )
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute('role', const HclValue.string('roles/pubsub.publisher'))
        ..attribute(
          'member',
          const HclValue.string(
            'serviceAccount:'
            r'${data.google_storage_project_service_account.'
            r'gcs_account.email_address}',
          ),
        ),
    );
  }

  blocks.add(
    HclBlock(
        type: 'resource',
        labels: const <String>[
          'google_service_account_iam_member',
          'pubsub_token_creator',
        ],
      )
      ..comment(
        'Grant Pub/Sub Service Agent permissions to generate OIDC tokens '
        'under our Custom SA',
      )
      ..attribute(
        'service_account_id',
        const HclValue.raw('google_service_account.eventarc_invoker.name'),
      )
      ..attribute(
        'role',
        const HclValue.string('roles/iam.serviceAccountTokenCreator'),
      )
      ..attribute(
        'member',
        const HclValue.string(
          'serviceAccount:service-'
          r'${data.google_project.project.number}'
          '@gcp-sa-pubsub.iam.gserviceaccount.com',
        ),
      ),
  );

  blocks.add(
    HclBlock(
        type: 'resource',
        labels: const <String>[
          'google_service_account_iam_member',
          'eventarc_sa_user',
        ],
      )
      ..comment(
        'Grant Eventarc Service Agent permissions to act as our Custom SA',
      )
      ..attribute(
        'service_account_id',
        const HclValue.raw('google_service_account.eventarc_invoker.name'),
      )
      ..attribute('role', const HclValue.string('roles/iam.serviceAccountUser'))
      ..attribute(
        'member',
        const HclValue.string(
          'serviceAccount:service-'
          r'${data.google_project.project.number}'
          '@gcp-sa-eventarc.iam.gserviceaccount.com',
        ),
      ),
  );

  return blocks;
}

HclBlock _buildEventarcTriggerBlock(TriggerConfig trigger, String serviceName) {
  final name = trigger.name;
  final type = trigger.type.identifier;
  final path = trigger.path;

  final meta = trigger.meta;
  final isGlobal = meta.isGlobal;

  final HclValue triggerLocationVal;
  if (meta.triggerLocation != null) {
    triggerLocationVal = HclValue.string(meta.triggerLocation!);
  } else {
    triggerLocationVal = const HclValue.raw('var.region');
  }

  final triggerBlock =
      HclBlock(
          type: 'resource',
          labels: <String>['google_eventarc_trigger', 'trigger_$name'],
        )
        ..comment('GCP Eventarc Trigger Mapping signals: $name')
        ..attribute('name', HclValue.string('$serviceName-$name-trigger'))
        ..attribute('location', triggerLocationVal);

  if (isGlobal) {
    triggerBlock.attribute('provider', const HclValue.raw('google-beta'));
  }

  if (meta.eventDataContentType != null) {
    triggerBlock.attribute(
      'event_data_content_type',
      HclValue.string(meta.eventDataContentType!),
    );
  }

  triggerBlock.attribute(
    'service_account',
    const HclValue.raw('google_service_account.eventarc_invoker.email'),
  );

  final cloudRunService = HclBlock(type: 'cloud_run_service')
    ..attribute(
      'service',
      const HclValue.raw('data.google_cloud_run_v2_service.service.name'),
    )
    ..attribute('region', const HclValue.raw('var.region'))
    ..attribute('path', HclValue.string(path));

  final destination = HclBlock(type: 'destination')..addBlock(cloudRunService);

  final criteriaList = [
    HclBlock(type: 'matching_criteria')
      ..attribute('attribute', const HclValue.string('type'))
      ..attribute('value', HclValue.string(type)),
  ];

  switch (trigger) {
    case FirestoreTriggerConfig(:final database, :final document):
      criteriaList.add(
        HclBlock(type: 'matching_criteria')
          ..attribute('attribute', const HclValue.string('database'))
          ..attribute('value', HclValue.string(database)),
      );
      criteriaList.add(
        HclBlock(type: 'matching_criteria')
          ..attribute('attribute', const HclValue.string('document'))
          ..attribute('value', HclValue.string(document)),
      );
    case StorageTriggerConfig(:final bucket):
      criteriaList.add(
        HclBlock(type: 'matching_criteria')
          ..attribute('attribute', const HclValue.string('bucket'))
          ..attribute('value', HclValue.string(bucket)),
      );
    case TriggerConfig():
      break;
  }

  triggerBlock.addBlock(destination);
  for (final criteria in criteriaList) {
    triggerBlock.addBlock(criteria);
  }
  return triggerBlock;
}

String _camelToSnake(String input) => input
    .replaceAllMapped(
      RegExp(r'(.)([A-Z])'),
      (Match match) => '${match.group(1)}_${match.group(2)}',
    )
    .toLowerCase();
