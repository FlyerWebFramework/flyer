import 'package:flyer/transpiler.dart';

import 'parsers/script_parser.dart';
import 'utils.dart';

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
        final lines = trimmedLine.split('\n');

        if (split[1].trim().substring(0, 7) == "Script(") {
          final parsedCode = ScriptParser().parse(lines);

          return TransformedCode(
            type: _type!,
            dart: Utils.indentCode(trimmedLine),
            javaScript: "function ${parsedCode.name}"
                "(${parsedCode.arguments.join()})"
                "${parsedCode.type == ScriptType.oneLine ? ' => ' : ' '}"
                "${parsedCode.body}",
          );
        } else {
          return null;
        }
      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}
