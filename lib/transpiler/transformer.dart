import 'package:flyer/transpiler.dart';

class Transformer {
  Transformer(this.fileLines);

  final List<String> fileLines;
  final List<TransformedCode> _stack = [];
  final _scanner = Scanner();
  var _openedFunction = 0;

  bool _isPointStartLine(String line) => line.substring(0, 1) == '@';

  bool _isPointEndLine(String line) => line.substring(line.length - 1, line.length) == ';';

  bool _checkPointType(String line, AnnotationType type) {
    return line.contains(type.toString());
  }

  void _findPoint(String trimmedLine) {
    if (_isPointStartLine(trimmedLine)) {
      for (var type in AnnotationType.values) {
        if (_checkPointType(trimmedLine, type)) {
          _scanner.startScanning(type);
          break;
        }
      }
    }
  }

  List<TransformedCode> transform() {
    for (String line in fileLines) {
      final String trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      if (_scanner.isScanning) {
        if (_isPointEndLine(trimmedLine) && _openedFunction <= 0) {
          _scanner.scan(trimmedLine);
          final transCode = _scanner.transform();
          if (transCode != null) _stack.add(transCode);
          _scanner.stopScanning();
        } else {
          _scanner.scan(trimmedLine);
          _openedFunction += trimmedLine.split('{').length-1;
          _openedFunction -= trimmedLine.split('}').length-1;
        }
      } else {
        _findPoint(trimmedLine);
      }
    }
    return _stack;
  }
}
