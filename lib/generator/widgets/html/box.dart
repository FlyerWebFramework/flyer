import 'package:flyer/flyer.dart';

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
    this.alignment,
    this.spacing,
    this.style,
    required this.children,
  });

  final Alignment? alignment;
  final Unit? spacing;
  final BoxStyle? style;
  final List<Widget> children;

  @override
  List<String> get classes => style?.classes ?? [];

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: [...classes, 'flex-col', if (alignment != null) '$alignment', if (spacing != null) 'gep-$spacing'],
      child: Render.list(children.map((e) => e.render(context)).toList()),
    );
  }
}
