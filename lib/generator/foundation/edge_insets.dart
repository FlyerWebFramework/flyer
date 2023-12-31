import 'package:flyer/generator/core/units.dart';

import 'text_style.dart';

enum Axis {
  /// Left and right.
  ///
  /// See also:
  ///
  ///  * [TextDirection], which disambiguates between left-to-right horizontal
  ///    content and right-to-left horizontal content.
  horizontal,

  /// Up and down.
  vertical,
}

class EdgeInsets {
  /// Creates insets from offsets from the left, top, right, and bottom.
  const EdgeInsets._init({
    this.all,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.horizontal,
    this.vertical,
  });

  static get zero => EdgeInsets.all(0.rem);

  /// Creates insets where all the offsets are `value`.
  ///
  /// {@tool snippet}
  ///
  /// Typical eight-pixel margin on all sides:
  ///
  /// ```dart
  /// const EdgeInsets.all(8.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.all(Unit value)
      : all = value,
        left = null,
        top = null,
        right = null,
        bottom = null,
        horizontal = null,
        vertical = null;

  /// Creates insets with only the given values non-zero.
  ///
  /// {@tool snippet}
  ///
  /// Left margin indent of 40 pixels:
  ///
  /// ```dart
  /// const EdgeInsets.only(left: 40.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.only({
    this.left,
    this.top,
    this.right,
    this.bottom,
  })  : all = null,
        horizontal = null,
        vertical = null;

  /// Creates insets with symmetrical vertical and horizontal offsets.
  ///
  /// {@tool snippet}
  ///
  /// Eight pixel margin above and below, no horizontal margins:
  ///
  /// ```dart
  /// const EdgeInsets.symmetric(vertical: 8.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.symmetric({
    this.vertical,
    this.horizontal,
  })  : all = null,
        left = null,
        top = null,
        right = null,
        bottom = null;

  /// An [EdgeInsets] with zero offsets in each direction.
  const EdgeInsets.empty()
      : all = null,
        left = null,
        top = null,
        right = null,
        bottom = null,
        horizontal = null,
        vertical = null;

  /// The offset from the all sides.
  final Unit? all;

  /// The offset from the left.
  final Unit? left;

  /// The offset from the top.
  final Unit? top;

  /// The offset from the right.
  final Unit? right;

  /// The offset from the bottom.
  final Unit? bottom;

  /// The offset from left and right.
  final Unit? horizontal;

  /// The offset from top and bottom.
  final Unit? vertical;

  /// Creates a copy of this EdgeInsets but with the given fields replaced
  /// with the new values.
  EdgeInsets copyWith({
    Unit? all,
    Unit? left,
    Unit? top,
    Unit? right,
    Unit? bottom,
    Unit? horizontal,
    Unit? vertical,
  }) {
    return EdgeInsets._init(
      all: all ?? this.all,
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      horizontal: horizontal ?? this.horizontal,
      vertical: vertical ?? this.vertical,
    );
  }

  List<String> getMarginClasses([ClassState state = ClassState.none]) {
    return [
      if (all != null) "${state}m-$all",
      if (left != null) "${state}ml-$left",
      if (top != null) "${state}mt-$top",
      if (right != null) "${state}mr-$right",
      if (bottom != null) "${state}mb-$bottom",
      if (horizontal != null) "${state}mx-$horizontal",
      if (vertical != null) "${state}my-$vertical",
    ];
  }

  List<String> getPaddingClasses([ClassState state = ClassState.none]) {
    return [
      if (all != null) "${state}p-$all",
      if (left != null) "${state}pl-$left",
      if (top != null) "${state}pt-$top",
      if (right != null) "${state}pr-$right",
      if (bottom != null) "${state}pb-$bottom",
      if (horizontal != null) "${state}px-$horizontal",
      if (vertical != null) "${state}py-$vertical",
    ];
  }
}
