import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
import 'package:path/path.dart' as path;

import 'border.dart';
import 'edge_insets.dart';
import 'text_style.dart';

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

  String _buildClass(String template, Object variable) {
    switch (variable) {
      case const (Unit):
      case const (Enum):
      case const (Color):
      default:
        _saveClass(template.replaceAll("{}", variable.toString()));
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

  ClassBuilder add(String template, Object? variable, {String prefix = ''}) {
    if (variable != null) {
      _saveClass(template.replaceAll("{}", variable.toString()));
      _classes.add(prefix+_buildClass(template, variable));
    }
    return this;
  }
}

class Size<T> {
  const Size(this.width, this.height);

  final T width;
  final T height;
}

class Decoration {
  const Decoration({
    this.width,
    this.height,
    this.color,
    this.border,
    this.margin,
    this.padding,
  });

  final Unit? width;
  final Unit? height;
  final Color? color;
  final Border? border;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  List<String> getClasses([ClassState state = ClassState.none]) {
    final builder = ClassBuilder();
    builder.add("${state}w-{}", width);
    builder.add("${state}h-{}", height);
    builder.add("${state}bg-{}", color);
    builder.addClassAll(border?.getClasses(state));
    builder.addClassAll(margin?.getMarginClasses(state));
    builder.addClassAll(padding?.getPaddingClasses(state));
    return builder.classes;
  }
}

class BoxDecoration extends Decoration {
  BoxDecoration({super.color, super.border});
}
