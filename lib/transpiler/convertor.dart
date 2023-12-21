class Convertor {
  Convertor(this.code);

  factory Convertor.fromString(String code) {
    return Convertor(code.split(''));
  }

  final List<String> code;

  final StringBuffer _stack = StringBuffer();

  bool readingBlock = false;
  bool readingString = false;
  bool readingStringInterpolation = false;
  int blockNum = 0;

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

    return reformat(_stack.toString());
  }

  String reformat(String code) {
    final List<String> body = [];
    List<String> characters = code.split('');
    for (String char in characters) {
      if (char == '"' || char == "'") {
        readingString = !readingString;
      }
      if (char == '\$' && readingString) {
        readingStringInterpolation = true;
      }
      if (char == ' ' && readingStringInterpolation) {
        readingStringInterpolation = false;
      }
      if (char == '{') {
        body.add(char);
        if (!readingStringInterpolation) {
          ++blockNum;
          readingBlock = true;
          body.add('\n');
          body.add('  ' * blockNum);
        }
      }
      if (!'{}'.contains(char)) {
        body.add(char);
        if (char == ';') {
          body.add('\n');
          body.add('  ' * blockNum);
        }
      }
      if (char == '}') {
        if (!readingStringInterpolation) {
          --blockNum;
          body.removeLast();
          body.add('\n');
          body.add('  ' * blockNum);
        } else {
          readingStringInterpolation = false;
        }
        body.add(char);
      }
    }

    return body.join();
  }
}
