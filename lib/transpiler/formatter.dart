///
/// Format code for better readability
///
class Formatter {
  bool readingBlock = false;
  bool readingString = false;
  bool readingStringInterpolation = false;
  int blockNum = 0;

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