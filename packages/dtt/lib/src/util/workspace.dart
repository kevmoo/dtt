import 'dart:io';
import 'package:path/path.dart' as p;

String? findWorkspaceRoot(String startDir) {
  var dir = Directory(startDir);
  while (true) {
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (pubspec.existsSync()) {
      final content = pubspec.readAsStringSync();
      if (content.contains('workspace:')) {
        return dir.path;
      }
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      break;
    }
    dir = parent;
  }
  return null;
}
