import 'package:flyer/flyer.dart';
import 'package:flyer/generator/widgets/html/flex_box.dart';

class Box extends Widget {
  const Box({
    this.style,
    required this.child,
  });

  final BoxStyle? style;
  final Widget child;

  @override
  List<String> get classes => style?.classes ?? [];

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
      child: child.render(context.copy),
    );
  }
}

class VBox extends Widget {
  const VBox({
    this.mainAlignment,
    this.crossAlignment,
    this.spacing,
    this.style,
    required this.children,
  });

  final MainAlignment? mainAlignment;
  final CrossAlignment? crossAlignment;
  final Unit? spacing;
  final BoxStyle? style;
  final List<Widget> children;

  @override
  Widget build() {
    return FlexBox(
      direction: Direction.vertical,
      style: style,
      spacing: spacing,
      mainAlignment: mainAlignment,
      crossAlignment: crossAlignment,
      children: children,
    );
  }
}

class HBox extends Widget {
  const HBox({
    this.mainAlignment,
    this.crossAlignment,
    this.spacing,
    this.style,
    required this.children,
  });

  final MainAlignment? mainAlignment;
  final CrossAlignment? crossAlignment;
  final Unit? spacing;
  final BoxStyle? style;
  final List<Widget> children;

  @override
  Widget build() {
    return FlexBox(
      direction: Direction.horizontal,
      style: style,
      spacing: spacing,
      mainAlignment: mainAlignment,
      crossAlignment: crossAlignment,
      children: children,
    );
  }
}
