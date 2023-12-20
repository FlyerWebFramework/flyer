class Convertor {
  Convertor(this.code);

  factory Convertor.fromString(String code) {
    return Convertor(code.split(''));
  }

  final List<String> code;

  final List<String> _stack = [];

  bool readingBlock = false;
  bool readingString = false;
  bool readingStringInterpolation = false;
  int blockNum = 0;

  String dartToJs() {
    for (String char in code) {
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
        _stack.add(char);
        if (!readingStringInterpolation) {
          ++blockNum;
          readingBlock = true;
          _stack.add('\n');
          _stack.add('  ' * blockNum);
        }
      }
      if (!'{}'.contains(char)) {
        _stack.add(char);
        if (char == ';') {
          _stack.add('\n');
          _stack.add('  ' * blockNum);
        }
      }
      if (char == '}') {
        if (!readingStringInterpolation) {
          --blockNum;
          _stack.removeLast();
          _stack.add('\n');
          _stack.add('  ' * blockNum);
        } else {
          readingStringInterpolation = false;
        }
        _stack.add(char);
      }
    }

    return _stack.join();
  }
}
