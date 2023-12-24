import 'package:flyer/generator/foundation.dart';

import 'border.dart';

class Colors {
  static const red = Color("red");

  static const yellow = Color("yellow");

  static const blue = Color("blue");

  static const green = Color("green");

  static const black = Color("black");

  static const white = Color("white");
}

class Color {
  const Color(this.value, {this.shade = 500, this.opacity = 1});

  final int? shade;
  final double? opacity;
  final String value;

  get shade50 => Color(value, shade: 50);

  get shade100 => Color(value, shade: 100);

  get shade200 => Color(value, shade: 200);

  get shade300 => Color(value, shade: 300);

  get shade400 => Color(value, shade: 400);

  get shade500 => Color(value, shade: 500);

  get shade600 => Color(value, shade: 600);

  get shade700 => Color(value, shade: 700);

  get shade800 => Color(value, shade: 800);

  get shade900 => Color(value, shade: 900);
}

enum EventType { click }

class BuildContext {}

class RenderContext {
  const RenderContext({this.indentation = -1, this.slot = false});

  final int indentation;
  final bool slot;

  RenderContext copyWith({int? indentation, bool? slot}) {
    return RenderContext(indentation: indentation ?? this.indentation, slot: slot ?? this.slot);
  }

  RenderContext get copy {
    return copyWith(indentation: indentation + 1);
  }

  RenderContext indent([int num = 1]) {
    return copyWith(indentation: indentation + num);
  }

  RenderContext indentBack([int num = 1]) {
    return copyWith(indentation: indentation - num);
  }
}

class Event {
  Event({required this.type, this.script});

  EventType type;
  final Script? script;
}

class Decoration {
  const Decoration({required this.color, required this.border});

  final Color color;
  final Border border;
}

class BoxDecoration extends Decoration {
  BoxDecoration({required super.color, required super.border});
}

enum Alignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class Scripts {
  late final Map<String, Script> _scripts;

  get list => _scripts;

  Script get(String key) => _scripts.containsKey(key) ? _scripts[key]! : throw 'Cannot find key: $key';

  Scripts(Map<String, dynamic> functions) {
    _scripts = functions.map((key, value) => MapEntry(key, Script.create(name: key, function: value)));
  }
}

class Script {
  final String name;
  final dynamic function;

  const Script(this.function, [this.name = "<unknown>"]);

  factory Script.create({required String name, dynamic function}) {
    return Script(function, name);
  }

  @override
  String toString() {
    return function;
  }
}
