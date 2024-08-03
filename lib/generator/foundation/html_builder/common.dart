enum EventType { click }

class Event {
  const Event({required this.type, this.action});

  final EventType type;
  final Action? action;
}

class Scripts {
  late final Map<String, Script> _scripts;

  Map<String, Script> get list => _scripts;

  Script get(String key) => _scripts.containsKey(key) ? _scripts[key]! : throw 'Cannot find key: $key';

  Scripts(Map<String, dynamic> functions) {
    _scripts = functions.map((key, value) => MapEntry(key, Script.create(name: key, function: value)));
  }
}

class Script extends Action {
  final String name;
  final dynamic function;

  const Script(this.function, [this.name = "<unknown>"]);

  factory Script.create({required String name, dynamic function}) {
    return Script(function, name);
  }

  @override
  String toString() {
    return '{$name}';
  }
}

sealed class Action {
  const Action();

  factory Action.openUrl(Uri url) = Url;
}

class Url extends Action {
  final Uri url;

  const Url(this.url);

  Url.open(this.url);

  @override
  String toString() {
    return url.toString();
  }
}

