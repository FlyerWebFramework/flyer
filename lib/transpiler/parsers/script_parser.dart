class ParsedScript {
  ParsedScript({
    required this.name,
    required this.arguments,
    required this.body,
  });

  final String name;
  final List<String> arguments;
  final String body;
}

class ScriptParser {
  String name = '';
  List<String> body = [];
  bool reading = false;
  int blockNum = 0;

  _parseName(String line) {
    bool read = false;
    List<String> stack = [];
    List<String> characters = line.split('');

    for (String char in characters) {
      if (char == ' ' && read) break;
      if (char == '#') read = true;
      if (read) stack.add(char);
    }
    name = stack.join().replaceAll('#', '').replaceAll(',', '');
  }

  void _readBody(String line) {
    List<String> characters = line.split('');
    for (String char in characters) {
      if (char == '{') {
        ++blockNum;
        reading = true;
        body.add(char);
        body.add('\n');
        body.add('  ' * blockNum);
      }
      if (blockNum > 0 && !'{}'.contains(char)) {
        body.add(char);
      }
      if (char == '}') {
        --blockNum;
        body.add('\n');
        body.add('  ' * blockNum);
        body.add(char);
      }
      if (blockNum <= 0 && reading) break;
    }
  }

  ParsedScript parse(String line) {
    final split = line.split('=');
    final lines = line.split('\n');

    if (split[1].trim().substring(0, 7) == "Script(") {
      for (String line in lines) {
        if (line.contains("name:") && name.isEmpty) _parseName(line);

        if (reading) _readBody(line);
        if (line.contains("function:")) {
          if (line.replaceAll(' ', '').contains('(){')) {
            _readBody(line);
          }
        }
      }

      return ParsedScript(
        name: name,
        arguments: [],
        body: body.join(),
      );
    } else {
      return ParsedScript(
        name: name,
        arguments: [],
        body: body.join(),
      );
    }
  }
}
