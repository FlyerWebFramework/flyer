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
      case const (Unit):
      case const (Enum):
      case const (Color):
      default:
        _saveClass(template.replaceAll("{}", variable.value.toString()));
        return template.replaceAll("{}", variable.toString());
    }
  }

  addDaisyClass(String? classStyle) {
    if (classStyle == null) return;
    _classes.add('${Constants.daisyPrefix}$classStyle');
  }

  addClass(String? classStyle) {
    if (classStyle == null) return;
    _classes.add(classStyle);
  }

  addClassAll(List<String>? classes) {
    if (classes == null) return;
    _classes.addAll(classes);
  }

  void add(String template, Variable? variable, {String prefix = ''}) {
    if (variable != null) {
      _saveClass(template.replaceAll("{}", variable.value.toString()));
      _classes.add(prefix+_buildClass(template, variable));
    }
  }
}
