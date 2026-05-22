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

/// Represents any value expression inside an HCL (HashiCorp Configuration
/// Language) file.
/// All implementations are closed and marked final to ensure immutability.
sealed class HclValue {
  const HclValue();

  /// Natively renders the value to its HCL representation.
  String render();

  /// Mapped literal String value. Wraps values in double quotes and escapes
  /// internally.
  const factory HclValue.string(String value) = _HclString;

  /// Mapped raw expression reference
  /// (e.g. `google_storage_bucket.sources.name`).
  const factory HclValue.raw(String expression) = _HclRaw;

  /// Mapped boolean literal.
  const factory HclValue.boolean(bool value) = _HclBoolean;

  /// Mapped numeric literal.
  const factory HclValue.number(num value) = _HclNumber;

  /// Mapped list array of multiple values.
  const factory HclValue.list(List<HclValue> values) = _HclList;

  /// Mapped object map of attribute properties.
  const factory HclValue.map(Map<String, HclValue> map) = _HclMap;
}

final class _HclString extends HclValue {
  final String value;
  const _HclString(this.value);

  @override
  String render() {
    // Escape all double quotes and backslashes cleanly
    final escaped = value.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
    return '"$escaped"';
  }
}

final class _HclRaw extends HclValue {
  final String expression;
  const _HclRaw(this.expression);

  @override
  String render() => expression;
}

final class _HclBoolean extends HclValue {
  final bool value;
  const _HclBoolean(this.value);

  @override
  String render() => value ? 'true' : 'false';
}

final class _HclNumber extends HclValue {
  final num value;
  const _HclNumber(this.value);

  @override
  String render() => value.toString();
}

final class _HclList extends HclValue {
  final List<HclValue> values;
  const _HclList(this.values);

  @override
  String render() {
    if (values.isEmpty) return '[]';
    final renderedItems = values.map((v) => v.render()).join(', ');
    return '[ $renderedItems ]';
  }
}

final class _HclMap extends HclValue {
  final Map<String, HclValue> map;
  const _HclMap(this.map);

  @override
  String render() {
    if (map.isEmpty) return '{}';
    final entries = map.entries
        .map((e) => '    ${e.key} = ${e.value.render()}')
        .join('\n');
    return '{\n$entries\n  }';
  }
}

/// Models a complete HCL configuration block
/// (e.g. resource, variable, outputs).
/// Locked down and final. Recursively manages indentation and alignment.
final class HclBlock {
  final String type;
  final List<String> labels;

  final Map<String, HclValue> _attributes = <String, HclValue>{};
  final List<HclBlock> _nestedBlocks = <HclBlock>[];
  final List<String> _comments = <String>[];

  HclBlock({required this.type, this.labels = const <String>[]});

  /// Appends a comment block documentation line at the top of the block.
  void comment(String text) {
    _comments.add(text);
  }

  /// Declares an attribute key-value property map under this block.
  void attribute(String key, HclValue value) {
    _attributes[key] = value;
  }

  /// Appends a recursive nested block child (e.g. `template { ... }`).
  void addBlock(HclBlock block) {
    _nestedBlocks.add(block);
  }

  /// Compiles this block recursively, applying proper indentation indents.
  /// Automatically aligns all `=` operators column-wise on the block
  /// attributes!
  String render([final int indentLevel = 0]) {
    final indent = '  ' * indentLevel;
    final nestedIndent = '  ' * (indentLevel + 1);
    final buffer = StringBuffer();

    // 1. Write comment lines
    for (final comm in _comments) {
      buffer.writeln('$indent# $comm');
    }

    // 2. Write block header
    buffer
      ..write(indent)
      ..write(type);
    for (final label in labels) {
      buffer.write(' "$label"');
    }
    buffer.writeln(' {');

    // 3. Write attributes (with Column Alignment for "=" signs!)
    if (_attributes.isNotEmpty) {
      final maxKeyLen = _attributes.keys
          .map((k) => k.length)
          .reduce((a, b) => a > b ? a : b);

      _attributes.forEach((key, value) {
        final padding = ' ' * (maxKeyLen - key.length);
        buffer.writeln('$nestedIndent$key$padding = ${value.render()}');
      });
    }

    // 4. Write recursive nested blocks
    if (_nestedBlocks.isNotEmpty) {
      if (_attributes.isNotEmpty) {
        buffer.writeln(); // Blank separation line
      }

      for (var i = 0; i < _nestedBlocks.length; i++) {
        buffer.write(_nestedBlocks[i].render(indentLevel + 1));
        if (i < _nestedBlocks.length - 1) {
          buffer.writeln(); // Separation blank line
        }
      }
    }

    buffer
      ..write(indent)
      ..writeln('}');
    return buffer.toString();
  }
}

/// Container modeling a complete Terraform HCL document configuration file.
final class HclFile {
  final List<HclBlock> _blocks = <HclBlock>[];

  HclFile();

  /// Registers a main, top-level HCL block instance under this document
  /// context.
  void addBlock(HclBlock block) {
    _blocks.add(block);
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    for (var i = 0; i < _blocks.length; i++) {
      buffer.write(_blocks[i].render());
      if (i < _blocks.length - 1) {
        buffer.writeln(); // Double blank lines separation between main blocks
      }
    }
    return buffer.toString();
  }
}
