import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

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
  final $<Script?>? script;
}

class Decoration {
  const Decoration({
    this.color,
    this.border,
    this.margin,
    this.padding,
  });

  final $<Color?>? color;
  final $<Border?>? border;
  final $<EdgeInsets?>? margin;
  final $<EdgeInsets?>? padding;

  List<String> getClasses([ClassState state = ClassState.none]) {
    final builder = ClassBuilder();
    builder.add("${state}bg-{}", color);
    builder.addClassAll(border?.value?.getClasses(state));
    builder.addClassAll(margin?.value?.getMarginClasses(state));
    builder.addClassAll(padding?.value?.getPaddingClasses(state));
    return builder.classes;
  }
}

class BoxDecoration extends Decoration {
  BoxDecoration({super.color, super.border});
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

abstract class ArgsObject {
  List get args => [];

  Map<String, dynamic> toArgs();
}

class Arguments {
  Arguments([Map<String, dynamic>? args]) {
    if (args != null) {
      for (var arg in args.entries) {
        _args[arg.key] = arg.value;
      }
    }
  }

  final Map<String, dynamic> _args = {};

  Map<String, String> get list => _args.map((key, value) => MapEntry(key, value.toString()));

  Arguments add(String name, dynamic value) {
    _args[name] = value;
    return this;
  }

  Arguments addObject(ArgsObject object) {
    for (var arg in object.toArgs().entries) {
      _args[arg.key] = arg.value;
    }
    return this;
  }

  $<T> get<T>(String key) {
    if (_args.containsKey(key)) {
      return $<T>(_args[key] as T?, name: key);
    } else {
      return $<T>(null, name: key);
    }
  }
}
