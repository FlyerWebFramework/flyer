import 'package:flyer/transpiler.dart';

class Scanner {
  bool isScanning = false;
  final StringBuffer _parts = StringBuffer();
  AnnotationType? _type;

  startScanning(AnnotationType type) {
    isScanning = true;
    _type = type;
  }

  stopScanning() {
    isScanning = false;
    _parts.clear();
    _type = null;
  }

  scan(String line) {
    _parts.writeln(line);
  }

  String _formatCode(String code) {
    final List<String> line = [];
    final List<String> text = [];
    final characters = code.split('');
    int tabNum = 0;
    for (String char in characters) {
      if ('{[('.contains(char)) {
        ++tabNum;
      }
      if (')]}'.contains(char)) {
        --tabNum;
        text.removeLast();
        text.add('  ' * tabNum);
      }
      if (char == '\n') {
        line.add(char);
        text.add(line.join());
        text.add('  ' * tabNum);
        line.clear();
      } else {
        line.add(char);
      }
    }
    text.add(line.join());

    return text.join();
  }

  TransformedCode? transform() {
    final trimmedLine = _parts.toString().trim();
    switch (_type) {
      case AnnotationType.observable:
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
      case AnnotationType.computed:
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
      case AnnotationType.script:
        final split = trimmedLine.split('=');

        if (split[1].trim().substring(0, 7) == "Script(") {
          return TransformedCode(
            type: _type!,
            dart: _formatCode(trimmedLine),
            javaScript: "Not implemented..",
          );
        } else {
          return null;
        }

      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}
