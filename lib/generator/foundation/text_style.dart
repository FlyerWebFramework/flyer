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
  none("no-underline"),
  underline("underline"),
  overline("overline"),
  lineThrough("line-through"),
  ;

  const TextDecoration(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}

enum ClassState {
  none,
  hover,
  focus,
  active,
  disabled,
  ;

  @override
  toString() => this == ClassState.none ? '' : '$name:';
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

  List<String> getClasses([ClassState state = ClassState.none]) {
    final builder = ClassBuilder();
    builder.add("${state}text-{}", color);
    builder.add("${state}text-{}", fontSize);
    builder.add("${state}font-{}", fontWeight);
    builder.add("$state{}", decoration);
    builder.add("${state}leading-{}", lineHeight);
    return builder.classes;
  }
}
