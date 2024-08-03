import 'package:flyer/generator/core/colors.dart';
import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/foundation.dart';

enum BorderStyle {
  none("border-"),
  solid("border-solid"),
  dashed("border-dashed"),
  dotted("border-dotted"),
  double("border-double"),
  hidden("border-hidden"),
  ;

  const BorderStyle(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}

class BorderSide {
  /// Creates the side of a border.
  ///
  /// By default, the border is 1.0 logical pixels wide and solid black.
  const BorderSide({
    this.color = Color.black,
    this.width = const Unit(1, unit: UnitType.px),
    this.style = BorderStyle.solid,
  });

  /// The color of this side of the border.
  final Color? color;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border. This means that
  /// the border will have the width of one physical pixel. Also, hairline
  /// rendering takes shortcuts when the path overlaps a pixel more than once.
  /// This means that it will render faster than otherwise, but it might
  /// double-hit pixels, giving it a slightly darker/lighter result.
  ///
  /// To omit the border entirely, set the [style] to [BorderStyle.none].
  final Unit? width;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none]. This skips
  /// painting the border, but the border still has a [width].
  final BorderStyle? style;

  /// A hairline black border that is not rendered.
  static const BorderSide none = BorderSide(width: Unit.empty(), style: BorderStyle.none);

  List<String> getClasses([ClassState state = ClassState.none]) {
    return [
      if (color != null) "${state}border-${color!.variableValue}",
      if (width != null) "${state}border-$width",
      if (style != null) "$state${style!.cssValue}",
    ];
  }
}

class Border implements Var {
  const Border._init({
    this.all = BorderSide.none,
    this.top = BorderSide.none,
    this.right = BorderSide.none,
    this.bottom = BorderSide.none,
    this.left = BorderSide.none,
    this.variableName,
  });

  final BorderSide? all;
  final BorderSide? top;
  final BorderSide? right;
  final BorderSide? bottom;
  final BorderSide? left;

  /// Creates a border with symmetrical vertical and horizontal sides.
  ///
  /// The `vertical` argument applies to the [left] and [right] sides, and the
  /// `horizontal` argument applies to the [top] and [bottom] sides.
  ///
  /// All arguments default to [BorderSide.none] and must not be null.
  const Border.symmetric({
    BorderSide vertical = BorderSide.none,
    BorderSide horizontal = BorderSide.none,
    this.variableName,
  })  : all = null,
        left = vertical,
        top = horizontal,
        right = vertical,
        bottom = horizontal;

  /// A uniform border with all sides the same color and width.
  ///
  /// The sides default to black solid borders, one logical pixel wide.
  factory Border.all({
    Color? color = Color.black,
    Unit? width = const Unit(1, unit: UnitType.px),
    BorderStyle? style,
  }) {
    return Border._init(all: BorderSide(color: color, width: width, style: style));
  }

  List<String> getClasses([ClassState state = ClassState.none]) => [
        if (all != null) ...all!.getClasses(state),
      ];

  @override
  get variableValue => throw UnimplementedError();

  @override
  final String? variableName;
}
