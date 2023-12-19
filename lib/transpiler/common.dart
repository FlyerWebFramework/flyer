enum PointLineType {
  observable,
  computed,
  ;

  const PointLineType();

  @override
  toString() => "@$name";
}


class TransformedCode {
  TransformedCode({
    required this.type,
    required this.dart,
    required this.javaScript,
  });

  PointLineType type;
  String dart;
  String javaScript;

  @override
  String toString() {
    int num = 70;
    return """$type:
${"=" * num}
  Dart: $dart 
${"-" * num}
    JS: $javaScript
${"=" * num}
""";
  }
}
