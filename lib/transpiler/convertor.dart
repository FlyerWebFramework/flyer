class Convertor {
  Convertor(this.code);

  factory Convertor.fromString(String code) {
    return Convertor(code.split(''));
  }

  final List<String> code;

  final StringBuffer _stack = StringBuffer();

  bool _scanFunction = true;

  String dartToJs() {
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
