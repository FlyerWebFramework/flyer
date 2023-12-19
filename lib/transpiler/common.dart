enum AnnotationType {
  observable,
  computed,
  script,
  ;

  const AnnotationType();

  @override
  toString() => "@$name";
}


class TransformedCode {
  TransformedCode({
    required this.type,
    required this.dart,
    required this.javaScript,
  });

  AnnotationType type;
  String dart;
  String javaScript;

  @override
  String toString() {
    int num = 70;
    return """$type:
${"=" * num}
Dart:\n$dart 
${"-" * num}
JavaScript:\n$javaScript
${"=" * num}
""";
  }
}
