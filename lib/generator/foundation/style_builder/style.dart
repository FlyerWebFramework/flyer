import 'package:flyer/generator/core/global.dart';
import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/core/colors.dart';

import 'tailwind_style.dart';

class Style {
  const Style._();

  static SizeStyle get size => SizeStyle();

  static EventStyle get on => EventStyle();

  static BackgroundStyle get background => BackgroundStyle();

  static BorderStyle get border => BorderStyle();
}

class Breakpoint {
  static List<TailwindStyle> small(List<TailwindStyle> styles) =>
      styles.map((e) => e.copyWith(breakpoint: 'sm')).toList();
}

class BorderStyle {
  BorderSideStyle get all => BorderSideStyle('');

  BorderSideStyle get left => BorderSideStyle('l');

  BorderSideStyle get top => BorderSideStyle('t');

  BorderSideStyle get right => BorderSideStyle('r');

  BorderSideStyle get bottom => BorderSideStyle('b');

  BorderCornerStyle get topLeft => BorderCornerStyle('tl');

  BorderCornerStyle get topRight => BorderCornerStyle('tr');

  BorderCornerStyle get bottomLeft => BorderCornerStyle('bl');

  BorderCornerStyle get bottomRight => BorderCornerStyle('br');
}

class SizeStyle {
  List<TailwindStyle> set({required Unit width, required Unit height}) => [this.width(height), this.height(height)];

  TailwindStyle width(Unit value) => TailwindStyle(type: 'w', value: value.toString());

  TailwindStyle height(Unit value) => TailwindStyle(type: 'h', value: value.toString());
}

class EventStyle {
  List<TailwindStyle> hover(List<TailwindStyle> styles) => styles.map((e) => e.copyWith(action: 'hover')).toList();
}

class BackgroundStyle {
  TailwindStyle color(Color value) {
    final tailwindStyleValue = TailwindStyle(type: 'bg', value: value.variableValue);
    if (value.variableName != null) {
      GlobalState.generatedTailwindStyles.add(tailwindStyleValue.toString());
      return TailwindStyle(type: 'bg', value: Var.format(value.variableName));
    }
    return tailwindStyleValue;
  }
}

class BorderSideStyle {
  BorderSideStyle(this.subType);

  final String subType;

  TailwindStyle width(Unit value) => TailwindStyle(type: 'border', subType: subType, value: value.toString());

  TailwindStyle color(Color value) => TailwindStyle(type: 'border', subType: subType, value: value.toString());

  TailwindStyle radius(Unit value) => TailwindStyle(type: 'rounded', subType: subType, value: value.toString());
}

class BorderCornerStyle {
  BorderCornerStyle(this.subType);

  final String subType;

  TailwindStyle radius(Unit value) => TailwindStyle(type: 'rounded', subType: subType, value: value.toString());
}
