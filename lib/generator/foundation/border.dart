import 'package:flyer/generator/core/colors.dart';

enum BorderStyle {
  /// Skip the border.
  none,

  /// Draw the border as a solid line.
  solid,

  // if you add more, think about how they will lerp
}

class BorderSide {
  /// Creates the side of a border.
  ///
  /// By default, the border is 1.0 logical pixels wide and solid black.
  const BorderSide({
    this.color = Color.black,
    this.width = 1.0,
    this.style = BorderStyle.solid,
    this.strokeAlign = 0.0,
  })  : assert(color != null),
        assert(width != null),
        assert(width >= 0.0),
        assert(style != null),
        assert(strokeAlign != null);

  /// The color of this side of the border.
  final Color color;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border. This means that
  /// the border will have the width of one physical pixel. Also, hairline
  /// rendering takes shortcuts when the path overlaps a pixel more than once.
  /// This means that it will render faster than otherwise, but it might
  /// double-hit pixels, giving it a slightly darker/lighter result.
  ///
  /// To omit the border entirely, set the [style] to [BorderStyle.none].
  final double width;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none]. This skips
  /// painting the border, but the border still has a [width].
  final BorderStyle style;
  final double strokeAlign;

  /// A hairline black border that is not rendered.
  static const BorderSide none = BorderSide(width: 0.0, style: BorderStyle.none);

  /// The border is drawn fully inside of the border path.
  ///
  /// This is the default.
  static const double strokeAlignInside = -1.0;

  /// The border is drawn on the center of the border path, with half of the
  /// [BorderSide.width] on the inside, and the other half on the outside of
  /// the path.
  static const double strokeAlignCenter = 0.0;

  /// The border is drawn on the outside of the border path.
  static const double strokeAlignOutside = 1.0;
}

class Border {
  const Border({
    this.top = BorderSide.none,
    this.right = BorderSide.none,
    this.bottom = BorderSide.none,
    this.left = BorderSide.none,
  });

  final BorderSide top;
  final BorderSide right;
  final BorderSide bottom;
  final BorderSide left;

  const Border.fromBorderSide(BorderSide side)
      : top = side,
        right = side,
        bottom = side,
        left = side;

  /// Creates a border with symmetrical vertical and horizontal sides.
  ///
  /// The `vertical` argument applies to the [left] and [right] sides, and the
  /// `horizontal` argument applies to the [top] and [bottom] sides.
  ///
  /// All arguments default to [BorderSide.none] and must not be null.
  const Border.symmetric({
    BorderSide vertical = BorderSide.none,
    BorderSide horizontal = BorderSide.none,
  })  : left = vertical,
        top = horizontal,
        right = vertical,
        bottom = horizontal;

  /// A uniform border with all sides the same color and width.
  ///
  /// The sides default to black solid borders, one logical pixel wide.
  factory Border.all({
    Color color = Color.black,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,
  }) {
    final BorderSide side = BorderSide(color: color, width: width, style: style, strokeAlign: strokeAlign);
    return Border.fromBorderSide(side);
  }
}
