import 'package:flyer/transpiler/transpiler.dart';
import 'package:flyer/transpiler/formatter.dart';
import 'package:flyer/transpiler/models/parsed_script.dart';

import 'common.dart';
import 'script_parser.dart';
import 'utils.dart';

///
/// Scan annotation and run convertor for transform Dart to JS
///
class Transformer {
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
    final code = _parts.toString().trim();
    switch (_type) {
      case AnnotationType.observable:
        final split = code.split('=');
        if (split.length != 2) throw "Error during parsing: $code";

        final name = split[0].trim().split(' ').last;
        final value = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $name = \$state($value);";

        return TransformedCode(
          type: _type!,
          dart: code,
          javaScript: transformed,
        );
      case AnnotationType.computed:
        final split = code.split('=>');
        if (split.length != 2) throw "Error during parsing: $code";

        final name = split[0].trim().split(' ').last;
        final value = split[1].substring(0, split[1].length - 1).trim();
        final transformed = "let $name = \$derived($value);";

        return TransformedCode(
          type: _type!,
          dart: code,
          javaScript: transformed,
        );
      case AnnotationType.script:
        final split = code.split(code.split('\n').first.contains('=>') ? '=>' : '=');

        if (split[1].trim().substring(0, 7) == "Script(") {
          final parsedCode = ScriptParser().parse(code);
          final convertedCode = Transpiler().dartToJs(parsedCode.body);
          final body = Formatter().reformat(convertedCode);

          return TransformedCode(
              type: _type!,
              dart: Utils.indentCode(code),
              javaScript: [
                "function ${parsedCode.name}",
                "(${parsedCode.arguments.join(', ')})",
                parsedCode.type == ScriptType.oneLine ? ' => ' : ' {\n  ',
                parsedCode.type == ScriptType.oneLine ? body : Utils.substring(body.replaceAll('\n', '\n  '), 0, -2),
                if (parsedCode.type == ScriptType.multiLine) '}',
              ].join());
        } else {
          return null;
        }
      case null:
        throw "Cannot transform when PointLineType is null";
    }
  }
}
