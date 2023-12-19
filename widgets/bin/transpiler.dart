import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final filePath = path.join(DartScript.self.pathToProjectRoot, arguments.first);

  final fileLines = await File(filePath).readAsLines();

  Transform(fileLines).process();
}

class Transform {
  Transform(this.fileLines);

  List<String> fileLines;
  bool isScanning = false;
  StringBuffer parts = StringBuffer();

  startScanning() => isScanning = true;

  stopScanning() => isScanning = false;

  isPointStartLine(String line) => line.substring(0, 1) == '@';

  isPointEndLine(String line) => line.substring(line.length-1, line.length) == ';';

  process() {
    for (String line in fileLines) {
      final String trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      if (isScanning) {
        if (isPointEndLine(trimmedLine)) {
          parts.write(trimmedLine);
          printTransformedCode();
          parts.clear();
          stopScanning();
          print("");
        } else {
          parts.write(trimmedLine);
        }
      } else {
        findPoint(trimmedLine);
      }
    }
  }

  findPoint(String trimmedLine) {
    if (isPointStartLine(trimmedLine)) {
      if (trimmedLine.contains("@observable")) {
        print(trimmedLine);
        startScanning();
      }
    }
  }

  printTransformedCode() {
    final trimmedLine = parts.toString();
    print("Original: $trimmedLine");

    final split = trimmedLine.split('=');
    if (split.length != 2) throw "Error during parsing: $trimmedLine";
    final variableName = split[0].trim().split(' ').last;
    final variableValue = split[1].substring(0, split[1].length - 1).trim();
    final transformed = "let $variableName = \$state($variableValue);";

    print("Transformed: $transformed");
  }
}
