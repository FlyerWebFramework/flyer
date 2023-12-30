import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
import 'package:path/path.dart' as path;

class ClassBuilder {
  ClassBuilder([List<String>? classes]) {
    _classes = classes ?? [];
  }

  List<String> _classes = [];

  List<String> get classes => _classes..remove('');

  List<String> build() => classes;

  _saveClass(String line) {
    final genClassesPath = path.join(Constants.webPath!, "src", "lib", "index.js");
    final indexContent = File(genClassesPath).readAsStringSync();
    if (!indexContent.contains(line)) {
      genClassesPath.append("// $line");
    }
  }

  String _buildClass(String template, Variable variable) {
    switch (variable.value) {
      case Unit:
      case Enum:
      case Color:
      default:
        _saveClass(template.replaceAll("{}", variable.value.toString()));
        return template.replaceAll("{}", variable.toString());
    }
  }

  void add(String template, Variable? variable) {
    if (variable != null) {
      _saveClass(template.replaceAll("{}", variable.value.toString()));
      _classes.add(_buildClass(template, variable));
    }
  }
}
