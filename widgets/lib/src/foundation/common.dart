import 'border.dart';

enum Color { red, yellow, blue, green, black, white }

class BuildContext {}

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
