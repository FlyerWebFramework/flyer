import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final filePath = path.join(DartScript.self.pathToProjectRoot, arguments.first);

  final fileLines = await File(filePath).readAsLines();

  List<TransformedCode> transformedCode = Transform(fileLines).process();
  transformedCode.forEach(print);
}

enum PointLineType {
  observable,
  computed,
  ;

  const PointLineType();

  @override
  toString() => "@$name";
}

class Scanner {
  bool isScanning = false;
  final StringBuffer _parts = StringBuffer();
  PointLineType? _type;

  startScanning(PointLineType type) {
    isScanning = true;
    _type = type;
  }

  stopScanning() {
    isScanning = false;
    _parts.clear();
    _type = null;
  }

  scan(String line) {
    _parts.write(line);
  }

  TransformedCode transform() {
    final trimmedLine = _parts.toString();
    switch (_type) {
      case PointLineType.observable:
        final split = trimmedLine.split('=');
        if (split.length != 2) throw "Error during parsing: $trimmedLine";
        final variableName = split[0].trim().split(' ').last;
        final variableValue = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $variableName = \$state($variableValue);";

        return TransformedCode(
          type: _type!,
          dart: trimmedLine,
          javaScript: transformed,
        );
      case PointLineType.computed:
        return TransformedCode(
          type: _type!,
          dart: trimmedLine,
          javaScript: "Not implemented yet..",
        );
      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}

class TransformedCode {
  TransformedCode({
    required this.type,
    required this.dart,
    required this.javaScript,
  });

  PointLineType type;
  String dart;
  String javaScript;

  @override
  String toString() {
    int num = 70;
    return """$type:
${"=" * num}
  Dart: $dart 
${"-" * num}
    JS: $javaScript
${"=" * num}
""";
  }
}

class Transform {
  Transform(this.fileLines);

  final List<String> fileLines;
  final List<TransformedCode> _stack = [];
  final _scanner = Scanner();

  bool _isPointStartLine(String line) => line.substring(0, 1) == '@';

  bool _isPointEndLine(String line) => line.substring(line.length - 1, line.length) == ';';

  bool _checkPointType(String line, PointLineType type) {
    return line.contains(type.toString());
  }

  void _findPoint(String trimmedLine) {
    if (_isPointStartLine(trimmedLine)) {
      for (var type in PointLineType.values) {
        if (_checkPointType(trimmedLine, type)) {
          _scanner.startScanning(type);
          break;
        }
      }
    }
  }

  List<TransformedCode> process() {
    for (String line in fileLines) {
      final String trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      if (_scanner.isScanning) {
        if (_isPointEndLine(trimmedLine)) {
          _scanner.scan(trimmedLine);
          _stack.add(_scanner.transform());
          _scanner.stopScanning();
        } else {
          _scanner.scan(trimmedLine);
        }
      } else {
        _findPoint(trimmedLine);
      }
    }
    return _stack;
  }
}
