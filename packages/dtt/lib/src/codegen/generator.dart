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

    final labelsNode = serviceNode['labels'] as YamlMap?;
    final labels = <String, String>{};
    if (labelsNode != null) {
      for (final entry in labelsNode.entries) {
        labels[entry.key.toString()] = entry.value.toString();
      }
    }

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

    final securityProfile =
        serviceNode['security_profile'] as String? ?? 'default';

    // 1. Generate the server entrypoint inside package bin/
    await _generateServer(serviceName, triggers);

    // 2. Generate secure regional Terraform manifests at root
    await _generateTerraform(
      serviceName,
      projectId,
      region,
      securityProfile,
      triggers,
      labels,
    );
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
      'package:dtt_runtime/dtt_runtime.dart',
      'package:google_cloud_events/google_cloud_events.dart',
      'package:google_cloud_shelf/google_cloud_shelf.dart',
      'package:shelf/shelf.dart',
    };

    final packageName = p.basename(packageDir);

    for (final trigger in triggers) {
      final handler = trigger.handler;
      imports.add(
        'package:$packageName/src/handlers/'
        '${_toSnakeCase(handler)}.dart',
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

  Future<void> _generateTerraform(
    final String serviceName,
    final String projectId,
    final String region,
    final String securityProfile,
    final List<TriggerConfig> triggers,
    final Map<String, String> labels,
  ) async {
    final tfDir = Directory(p.join(workspaceRoot, 'terraform'));
    if (!await tfDir.exists()) {
      await tfDir.create(recursive: true);
    }

    final saSuffix = serviceName.length > 15
        ? serviceName.substring(0, 15)
        : serviceName;
    final saAccountId = 'dtt-$saSuffix-inv';

    // 1. Synthesize terraform/main.tf
    final mainFile = _buildMainTf(
      serviceName: serviceName,
      saAccountId: saAccountId,
      securityProfile: securityProfile,
      triggers: triggers,
      labels: labels,
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

  final varImage =
      HclBlock(type: 'variable', labels: const <String>['container_image'])
        ..attribute('type', const HclValue.raw('string'))
        ..attribute(
          'description',
          const HclValue.string(
            'Target Docker/Artifact Registry container image URL or digest.',
          ),
        );
  variablesFile.addBlock(varImage);

  final varGcloud =
      HclBlock(type: 'variable', labels: const <String>['gcloud_path'])
        ..attribute('type', const HclValue.raw('string'))
        ..attribute(
          'description',
          const HclValue.string(
            'Executable path or command name for the Google Cloud SDK CLI.',
          ),
        )
        ..attribute('default', const HclValue.string('gcloud'));
  variablesFile.addBlock(varGcloud);

  return variablesFile;
}

HclFile _buildOutputsTf(List<TriggerConfig> triggers) {
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
            'URL of our deployed serverless Dart Cloud Run service container.',
          ),
        );
  outputsFile.addBlock(outputUrl);

  final triggerRefs = <HclValue>[];
  for (final trigger in triggers) {
    final name = _toSnakeCase(trigger.name);
    final triggerBlock = HclBlock(
      type: 'resource',
      labels: ['google_eventarc_trigger', 'trigger_$name'],
    );
    triggerRefs.add(triggerBlock.ref('id'));
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

HclBlock _buildSecureCloudRunModuleResource({required String serviceName}) {
  return HclBlock(type: 'module', labels: const <String>['secure_cloud_run'])
    ..comment(
      'Official Google Cloud Run Security Blueprint Module (secure-cloud-run-core)',
    )
    ..attribute(
      'source',
      const HclValue.string('GoogleCloudPlatform/cloud-run/google'),
    )
    ..attribute('version', const HclValue.string('~> 0.12.0'))
    ..attribute('service_name', HclValue.string(serviceName))
    ..attribute('project_id', const HclValue.raw('var.project_id'))
    ..attribute('location', const HclValue.raw('var.region'))
    ..attribute('image', const HclValue.raw('var.container_image'))
    ..attribute('serverless_neg_only', const HclValue.boolean(true));
}

HclFile _buildMainTf({
  required String serviceName,
  required String saAccountId,
  required String securityProfile,
  required List<TriggerConfig> triggers,
  required Map<String, String> labels,
}) {
  final mainFile = HclFile();
  final hasGlobal = triggers.any((t) => t.meta.isGlobal);

  final serviceResource = _buildCloudRunV2ServiceResource(
    serviceName: serviceName,
  );
  final projectData = HclBlock(
    type: 'data',
    labels: const <String>['google_project', 'project'],
  );
  final serviceAccount = HclBlock(
    type: 'resource',
    labels: const <String>['google_service_account', 'eventarc_invoker'],
  );

  for (final block in _buildCoreProvidersAndDataSources(
    hasGlobal,
    labels,
    projectData,
  )) {
    mainFile.addBlock(block);
  }

  if (securityProfile == 'secure') {
    mainFile.addBlock(
      _buildSecureCloudRunModuleResource(serviceName: serviceName),
    );
  }

  mainFile.addBlock(serviceResource);

  for (final block in _buildServiceAccountAndInvoker(
    saAccountId,
    serviceName,
    serviceAccount,
    serviceResource,
  )) {
    mainFile.addBlock(block);
  }

  for (final block in _buildServiceAgentIamBlocks(
    triggers,
    serviceName,
    projectData,
    serviceAccount,
  )) {
    mainFile.addBlock(block);
  }

  for (final trigger in triggers) {
    mainFile.addBlock(
      _buildEventarcTriggerBlock(
        trigger,
        serviceName,
        serviceAccount,
        serviceResource,
      ),
    );
  }

  return mainFile;
}

HclBlock _buildCloudRunV2ServiceResource({required String serviceName}) {
  final serviceResource =
      HclBlock(
          type: 'resource',
          labels: const <String>['google_cloud_run_v2_service', 'service'],
        )
        ..comment('Declarative Cloud Run v2 Service Specification')
        ..attribute('name', HclValue.string(serviceName))
        ..attribute('location', const HclValue.raw('var.region'))
        ..attribute(
          'ingress',
          const HclValue.string('INGRESS_TRAFFIC_INTERNAL_ONLY'),
        )
        ..attribute('deletion_protection', const HclValue.boolean(false));

  final containersBlock = HclBlock(type: 'containers')
    ..attribute('image', const HclValue.raw('var.container_image'));

  final portsBlock = HclBlock(type: 'ports')
    ..attribute('container_port', const HclValue.number(8080));

  containersBlock.addBlock(portsBlock);

  final templateBlock = HclBlock(type: 'template');
  templateBlock.addBlock(containersBlock);

  serviceResource.addBlock(templateBlock);
  return serviceResource;
}

List<HclBlock> _buildCoreProvidersAndDataSources(
  bool hasGlobal,
  Map<String, String> labels,
  HclBlock projectData,
) {
  final reqProvidersBlock = HclBlock(type: 'required_providers')
    ..attribute(
      'google',
      const HclValue.map(<String, HclValue>{
        'source': HclValue.string('hashicorp/google'),
        'version': HclValue.string('>= 5.0.0'),
      }),
    );

  if (hasGlobal) {
    reqProvidersBlock.attribute(
      'google-beta',
      const HclValue.map(<String, HclValue>{
        'source': HclValue.string('hashicorp/google-beta'),
        'version': HclValue.string('>= 5.0.0'),
      }),
    );
  }

  final tfConfig = HclBlock(type: 'terraform')
    ..attribute('required_version', const HclValue.string('>= 1.3.0'))
    ..addBlock(reqProvidersBlock);

  final mergedLabels = <String, HclValue>{
    'managed_by': const HclValue.string('dart_terraform_triggers'),
    for (final e in labels.entries) e.key: HclValue.string(e.value),
  };

  final provider = HclBlock(type: 'provider', labels: const <String>['google'])
    ..attribute('project', const HclValue.raw('var.project_id'))
    ..attribute('region', const HclValue.raw('var.region'))
    ..attribute('default_labels', HclValue.map(mergedLabels));

  final blocks = <HclBlock>[tfConfig, provider];

  if (hasGlobal) {
    final providerBeta =
        HclBlock(type: 'provider', labels: const <String>['google-beta'])
          ..attribute('project', const HclValue.raw('var.project_id'))
          ..attribute('region', const HclValue.raw('var.region'))
          ..attribute('default_labels', HclValue.map(mergedLabels));
    blocks.add(providerBeta);
  }

  projectData.comment(
    'Retrieve live project metadata for Service Agent referencing',
  );

  blocks.add(projectData);
  return blocks;
}

List<HclBlock> _buildServiceAccountAndInvoker(
  String saAccountId,
  String serviceName,
  HclBlock serviceAccount,
  HclBlock serviceResource,
) {
  serviceAccount
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
          'Grant Invoker Service Account authorization to call our Cloud Run container',
        )
        ..attribute('name', serviceResource.ref('name'))
        ..attribute('location', serviceResource.ref('location'))
        ..attribute('role', const HclValue.string('roles/run.invoker'))
        ..attribute(
          'member',
          HclValue.string('serviceAccount:${serviceAccount.interp("email")}'),
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
          'Bind Eventarc Receiver permissions to standard GCP service agent profiles',
        )
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute(
          'role',
          const HclValue.string('roles/eventarc.eventReceiver'),
        )
        ..attribute(
          'member',
          HclValue.string('serviceAccount:${serviceAccount.interp("email")}'),
        );

  return [serviceAccount, iamMember, iamReceiver];
}

List<HclBlock> _buildServiceAgentIamBlocks(
  List<TriggerConfig> triggers,
  String serviceName,
  HclBlock projectData,
  HclBlock serviceAccount,
) {
  final blocks = <HclBlock>[];
  final hasFirestore = triggers.any((t) => t is FirestoreTriggerConfig);
  final hasStorage = triggers.any((t) => t is StorageTriggerConfig);

  if (hasFirestore) {
    // TASK-201: Scope Pub/Sub publisher role to target topic
    final firestoreTopic =
        HclBlock(
            type: 'resource',
            labels: const <String>['google_pubsub_topic', 'firestore_topic'],
          )
          ..comment(
            'Target Pub/Sub transport topic for Firestore Eventarc signals',
          )
          ..attribute('name', HclValue.string('$serviceName-firestore-topic'));
    blocks.add(firestoreTopic);

    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_pubsub_topic_iam_member',
            'firestore_pubsub_publisher',
          ],
        )
        ..comment(
          'Grant Cloud Firestore Service Agent permissions on specific Pub/Sub topic (Least Privilege)',
        )
        ..attribute('topic', firestoreTopic.ref('name'))
        ..attribute('role', const HclValue.string('roles/pubsub.publisher'))
        ..attribute(
          'member',
          HclValue.string(
            'serviceAccount:service-${projectData.interp("number")}'
            '@gcp-sa-firestore.iam.gserviceaccount.com',
          ),
        ),
    );

    // TASK-202: Replace allServices audit config with targeted firestore.googleapis.com audit config
    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_project_iam_audit_config',
            'firestore_audit',
          ],
        )
        ..comment(
          'Enable Targeted Data Access Audit Logs for Cloud Firestore (Least Privilege)',
        )
        ..attribute('project', const HclValue.raw('var.project_id'))
        ..attribute(
          'service',
          const HclValue.string('firestore.googleapis.com'),
        )
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
    final gcsAccountData = HclBlock(
      type: 'data',
      labels: const <String>[
        'google_storage_project_service_account',
        'gcs_account',
      ],
    );
    blocks.add(gcsAccountData);

    // TASK-201: Scope Pub/Sub publisher role to target topic for Cloud Storage
    final storageTopic =
        HclBlock(
            type: 'resource',
            labels: const <String>['google_pubsub_topic', 'storage_topic'],
          )
          ..comment(
            'Target Pub/Sub transport topic for Storage Eventarc signals',
          )
          ..attribute('name', HclValue.string('$serviceName-storage-topic'));
    blocks.add(storageTopic);

    blocks.add(
      HclBlock(
          type: 'resource',
          labels: const <String>[
            'google_pubsub_topic_iam_member',
            'storage_pubsub_publisher',
          ],
        )
        ..comment(
          'Grant Cloud Storage Service Agent permissions on specific Pub/Sub topic (Least Privilege)',
        )
        ..attribute('topic', storageTopic.ref('name'))
        ..attribute('role', const HclValue.string('roles/pubsub.publisher'))
        ..attribute(
          'member',
          HclValue.string(
            'serviceAccount:${gcsAccountData.interp("email_address")}',
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
        'Grant Pub/Sub Service Agent permissions to generate OIDC tokens under our Custom SA',
      )
      ..attribute('service_account_id', serviceAccount.ref('name'))
      ..attribute(
        'role',
        const HclValue.string('roles/iam.serviceAccountTokenCreator'),
      )
      ..attribute(
        'member',
        HclValue.string(
          'serviceAccount:service-${projectData.interp("number")}'
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
      ..attribute('service_account_id', serviceAccount.ref('name'))
      ..attribute('role', const HclValue.string('roles/iam.serviceAccountUser'))
      ..attribute(
        'member',
        HclValue.string(
          'serviceAccount:service-${projectData.interp("number")}'
          '@gcp-sa-eventarc.iam.gserviceaccount.com',
        ),
      ),
  );

  return blocks;
}

HclBlock _buildEventarcTriggerBlock(
  TriggerConfig trigger,
  String serviceName,
  HclBlock serviceAccount,
  HclBlock serviceResource,
) {
  final rawName = trigger.name;
  final hclName = _toSnakeCase(rawName);
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
          labels: <String>['google_eventarc_trigger', 'trigger_$hclName'],
        )
        ..comment('GCP Eventarc Trigger Mapping signals: $rawName')
        ..attribute('name', HclValue.string('$serviceName-$rawName-trigger'))
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

  triggerBlock.attribute('service_account', serviceAccount.ref('email'));

  final cloudRunService = HclBlock(type: 'cloud_run_service')
    ..attribute('service', serviceResource.ref('name'))
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

String _toSnakeCase(String input) => input
    .replaceAllMapped(
      RegExp(r'(.)([A-Z])'),
      (Match match) => '${match.group(1)}_${match.group(2)}',
    )
    .replaceAll('-', '_')
    .toLowerCase();
