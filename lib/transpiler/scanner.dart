import 'package:flyer/transpiler.dart';

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
