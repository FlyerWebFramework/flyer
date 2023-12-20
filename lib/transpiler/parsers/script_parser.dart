import 'package:flyer/transpiler/utils.dart';

enum ScriptType { multiLine, oneLine }

class ParsedScript {
  ParsedScript({
    required this.name,
    required this.arguments,
    required this.body,
    required this.type,
  });

  final String name;
  final List<String> arguments;
  final String body;
  final ScriptType type;
}

class ScriptParser {
  String name = '';
  List<String> body = [];
  ScriptType? type;
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

  void _parseMultiLineBody(String line) {
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
        if (char == ';') {
          body.add('\n');
          body.add('  ' * blockNum);
        }
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

  _parseOneLineBody(String line) {
    final lambdaBody = line.split('=>')[1].trim().split('');

    if (lambdaBody.last == ',') {
      lambdaBody.removeLast();
    }
    body = lambdaBody;
  }

  ParsedScript parse(List<String> lines) {
    for (String line in lines) {
      if (line.contains("name:") && name.isEmpty) _parseName(line);

      if (reading) _parseMultiLineBody(line);
      if (line.contains("function:")) {
        if (line.replaceAll(' ', '').contains('){')) {
          type = ScriptType.multiLine;
          _parseMultiLineBody(line);
        } else if (line.replaceAll(' ', '').contains(')=>')) {
          type = ScriptType.oneLine;
          _parseOneLineBody(line);
        }
      }
    }

    return ParsedScript(
      name: name,
      arguments: [],
      body: body.join(''),
      type: type!,
    );
  }
}
