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

        final name = split[0].trim().split(' ').last;
        final value = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $name = \$state($value);";

        return TransformedCode(
          type: _type!,
          dart: trimmedLine,
          javaScript: transformed,
        );
      case PointLineType.computed:
        final split = trimmedLine.split('=>');
        if (split.length != 2) throw "Error during parsing: $trimmedLine";

        final name = split[0].trim().split(' ').last;
        final value = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $name = \$derived($value);";

        return TransformedCode(
          type: _type!,
          dart: trimmedLine,
          javaScript: transformed,
        );
      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}
