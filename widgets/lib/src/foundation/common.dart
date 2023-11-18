import 'package:widgets/widgets.dart';

enum Color { red, yellow, blue, green, black, white }

enum EventType { click }

class BuildContext {}

class RenderContext {
  const RenderContext({this.indentation = -1});

  final int indentation;

  RenderContext get copy {
    return RenderContext(indentation: indentation + 1);
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
  late final Map<Symbol, Script> _scripts;

  Script get(Symbol key) => _scripts.containsKey(key) ? _scripts[key]! : throw 'Cannot find key: $key';

  Scripts(Map<Symbol, Function> functions) {
    _scripts = functions.map((key, value) => MapEntry(key, Script(name: key, function: value)));
  }
}

class Script {
  final Symbol name;
  final Function function;

  Script({required this.name, required this.function});
}
