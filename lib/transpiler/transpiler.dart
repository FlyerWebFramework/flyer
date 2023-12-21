///
/// Transpile Dart code into JS code
///
class Transpiler {
  final StringBuffer _stack = StringBuffer();

  bool _scanFunction = true;

  String dartToJs(List<String> code) {
    StringBuffer buffer = StringBuffer();
    for (String char in code) {

      if (';\n'.contains(char)) {
        if (_scanFunction) {
          buffer.write(char);
        } else {
          _stack.write(char);
        }
        continue;
      }

      if (char == '(') {
        _scanFunction = true;
        buffer.write(char);
        continue;
      }
      if (char == ')') {
        _scanFunction = false;
        _stack.write(buffer.toString().replaceAll('print(', 'console.log('));
        _stack.write(char);
        buffer.clear();
        continue;
      }

      buffer.write(char);
    }

    _stack.write(buffer);

    return _stack.toString();
  }
}
