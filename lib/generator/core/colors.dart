import 'package:color/color.dart' as color;

class Color extends Object {
  static const transparent = NamedColor("transparent");

  static const red = NamedColor("red");

  static const yellow = NamedColor("yellow");

  static const blue = NamedColor("blue");

  static const green = NamedColor("green");

  static const gray = NamedColor("gray");

  static const black = NamedColor("black");

  static const white = NamedColor("white");

  String get value => "<unknown>";

  @override
  String toString() => value;

  factory Color.name(String value) = NamedColor;

  factory Color.hex(String value) = HexColor;

  factory Color.rgba(num r, num g, num b, num a) = RgbaColor;
}

class HexColor implements Color {
  HexColor(String hexCode) {
    _color = color.HexColor(hexCode);
  }

  color.HexColor? _color;

  @override
  String get value => "[${_color!.toCssString()}]";

  @override
  String toString() => value;
}

class RgbaColor implements Color {
  RgbaColor(num r, num g, num b, num a) {
    _color = color.RgbaColor(r, g, b, a);
  }

  color.RgbaColor? _color;

  @override
  String get value => "[${_color!.toCssString()}]";

  @override
  String toString() => value;
}

class NamedColor implements Color {
  const NamedColor(this.name, {this.shade = 500, this.opacity = 1});

  final String name;
  final int? shade;
  final double? opacity;

  @override
  String get value {
    if (name == 'black' || name == 'white' || name == 'transparent') return name;
    return "$name-$shade";
  }

  @override
  String toString() => value;

  NamedColor get shade50 => NamedColor(name, shade: 50);

  NamedColor get shade100 => NamedColor(name, shade: 100);

  NamedColor get shade200 => NamedColor(name, shade: 200);

  NamedColor get shade300 => NamedColor(name, shade: 300);

  NamedColor get shade400 => NamedColor(name, shade: 400);

  NamedColor get shade500 => NamedColor(name, shade: 500);

  NamedColor get shade600 => NamedColor(name, shade: 600);

  NamedColor get shade700 => NamedColor(name, shade: 700);

  NamedColor get shade800 => NamedColor(name, shade: 800);

  NamedColor get shade900 => NamedColor(name, shade: 900);
}
