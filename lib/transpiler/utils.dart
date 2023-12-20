class Utils {
  static String indentCode(String code) {
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

  static lastChar(String text) {
    return text.trim().split('').last;
  }

  static substring(String text, int start, [int end = 0]) {
    return text.substring(start, end <= 0 ? text.length + end : end);
  }
}