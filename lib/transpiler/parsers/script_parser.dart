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
  List<String> arguments = [];
  ScriptType? type;

  bool parsingFunction = false;
  bool readingArgs = false;
  bool readingBody = false;
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
        readingBody = true;
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
        if (blockNum <= 0 && readingBody) {
          readingBody = false;
          parsingFunction = false;
          body.removeLast();
        } else {
          body.add('\n');
          body.add('  ' * blockNum);
        }
        body.add(char);
      }
    }
  }

  _parseOneLineBody(String line) {
    final lambdaBody = line.split('=>')[1].trim().split('');

    if (lambdaBody.last == ',') {
      lambdaBody.removeLast();
    }
    body = lambdaBody;
    parsingFunction = false;
  }

  _parseMultiLineArguments(String line) {
    if (!line.contains(')')) {
      readingArgs = true;
      arguments.add(line.trim());
    } else {
      readingArgs = false;
      arguments.add(line.trim());
      _parseOneLineArguments(arguments.join());
      arguments.remove('');
    }
  }

  _parseOneLineArguments(String line) {
    arguments = line
        .split('(')[1]
        .split(')')[0]
        .replaceAll(RegExp(r'<[a-zA-Z0-9]\w+,?\s?[a-zA-Z0-9]\w+>'), '')
        .split(',')
        .map((e) => e.split(' ').last)
        .toList();
  }

  ParsedScript parse(List<String> lines) {
    for (String line in lines) {
      if (line.contains("name:") && name.isEmpty) _parseName(line);

      if (readingBody) _parseMultiLineBody(line);
      if (readingArgs) _parseMultiLineArguments(line);
      if (line.contains("function:") || parsingFunction) {
        parsingFunction = true;
        if (line.contains('(') && line.contains(')') && !readingBody) {
          _parseOneLineArguments(line);
        }
        if (line.replaceAll(' ', '').contains('){')) {
          type = ScriptType.multiLine;
          _parseMultiLineBody(line);
        } else if (line.replaceAll(' ', '').contains(')=>')) {
          type = ScriptType.oneLine;
          _parseOneLineBody(line);
        } else if (Utils.lastChar(line) == '(' && !readingBody) {
          _parseMultiLineArguments(line);
        } else {
          return ParsedScript(
            name: "Unknown",
            arguments: arguments,
            body: body.join(''),
            type: ScriptType.multiLine,
          );
        }
      }
    }

    return ParsedScript(
      name: name,
      arguments: arguments,
      body: body.join(''),
      type: type!,
    );
  }
}
