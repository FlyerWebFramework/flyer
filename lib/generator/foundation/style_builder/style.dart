import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/core/colors.dart';

import 'tailwind_style.dart';

class Style {
  const Style._();

  static SizeStyle get size => SizeStyle();

  static EventStyle get on => EventStyle();

  static BackgroundStyle get background => BackgroundStyle();
}

class Breakpoint {
  static List<TailwindStyle> small(List<TailwindStyle> styles) =>
      styles.map((e) => e.copyWith(breakpoint: 'sm')).toList();
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
  TailwindStyle color(Color value) => TailwindStyle(type: 'bg', value: value.toString());
}
