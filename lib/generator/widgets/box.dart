import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';
import 'package:flyer/generator/foundation/styles/box_style.dart';

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
