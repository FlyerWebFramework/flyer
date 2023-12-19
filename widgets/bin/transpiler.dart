import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final filePath = path.join(DartScript.self.pathToProjectRoot, arguments.first);

  final fileLines = await File(filePath).readAsLines();

  Transform(fileLines).process();
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

  String transform() {
    switch (_type) {
      case PointLineType.observable:
        final trimmedLine = _parts.toString();
        print(trimmedLine);

        final split = trimmedLine.split('=');
        if (split.length != 2) throw "Error during parsing: $trimmedLine";
        final variableName = split[0].trim().split(' ').last;
        final variableValue = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $variableName = \$state($variableValue);";

        return transformed;
      case PointLineType.computed:
        return "todo";
      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}

class Transform {
  Transform(this.fileLines);

  final scanner = Scanner();
  List<String> fileLines;

  isPointStartLine(String line) => line.substring(0, 1) == '@';

  isPointEndLine(String line) => line.substring(line.length - 1, line.length) == ';';

  process() {
    for (String line in fileLines) {
      final String trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      if (scanner.isScanning) {
        if (isPointEndLine(trimmedLine)) {
          scanner.scan(trimmedLine);
          print(scanner.transform());
          scanner.stopScanning();
          print("");
        } else {
          scanner.scan(trimmedLine);
        }
      } else {
        findPoint(trimmedLine);
      }
    }
  }

  bool checkPointType(String line, PointLineType type) {
    return line.contains(type.toString());
  }

  findPoint(String trimmedLine) {
    if (isPointStartLine(trimmedLine)) {
      for (var type in PointLineType.values) {
        if (checkPointType(trimmedLine, type)) {
          print(trimmedLine);
          scanner.startScanning(type);
          break;
        }
      }
    }
  }
}
