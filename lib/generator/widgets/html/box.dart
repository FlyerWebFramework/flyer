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
