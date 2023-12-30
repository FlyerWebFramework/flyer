import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

import 'border.dart';

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
  topLeft(""),
  topCenter(""),
  topRight(""),
  centerLeft("grid items-center justify-items-start"),
  center("grid items-center justify-items-center"),
  centerRight("grid items-center justify-items-end"),
  bottomLeft(""),
  bottomCenter(""),
  bottomRight(""),
  ;

  const Alignment(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}

class Scripts {
  late final Map<String, Script> _scripts;

  Map<String, Script> get list => _scripts;

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

abstract class PropObject {
  List get props => [];
}

class Props {
  final Map<String, dynamic> _props = {};

  Map<String, String> get list => _props.map((key, value) => MapEntry(key, value.toString()));

  $<T> get<T>(String key) {
    return _props.containsKey(key) ? $<T>(_props[key]! as T, name: key) : throw 'Cannot find key: $key';
  }

  Props(List<$> props) {
    for (var prop in props) {
      _props[prop.name!] = prop.value;
    }
  }
}
