import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/core/colors.dart';

import 'tailwind_style.dart';

class Style {
  const Style._();

  static Size get size => Size();

  static Event get on => Event();

  static Background get background => Background();
}

class Size {
  List<TailwindStyle> set({required Unit width, required Unit height}) => [this.width(height), this.height(height)];

  TailwindStyle width(Unit value) => TailwindStyle(type: 'w', value: value.toString());

  TailwindStyle height(Unit value) => TailwindStyle(type: 'h', value: value.toString());
}

class Event {
  List<TailwindStyle> hover(List<TailwindStyle> styles) => styles.map((e) => e.copyWith(action: 'hover')).toList();
}

class Background {
  TailwindStyle color(Color value) => TailwindStyle(type: 'bg', value: value.toString());
}

class Breakpoint {
  static List<TailwindStyle> small(List<TailwindStyle> styles) =>
      styles.map((e) => e.copyWith(breakpoint: 'sm')).toList();
}
