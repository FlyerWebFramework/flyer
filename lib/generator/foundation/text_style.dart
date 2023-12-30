import 'package:flyer/generator/core.dart';

enum FontWeight {
  normal,
  bold,
  italic,
  ;

  @override
  toString() => name;
}

enum TextDecoration {
  none,
  underline,
  overline,
  lineThrough,
  ;

  @override
  toString() => name;
}

class TextStyle {
  TextStyle({
    this.color,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.decoration,
  });

  final $<Color?>? color;
  final $<Unit?>? fontSize;
  final $<Unit?>? lineHeight;
  final $<FontWeight?>? fontWeight;
  final $<TextDecoration?>? decoration;

  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("text-{}", color);
    builder.add("text-{}", fontSize);
    builder.add("font-{}", fontWeight);
    builder.add("{}", decoration);
    builder.add("leading-{}", lineHeight);
    return builder.classes;
  }
}
