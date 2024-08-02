import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Box extends Widget {
  const Box({
    this.width,
    this.height,
    this.color,
    this.margin,
    this.border,
    this.padding,
    this.alignment,
    required this.child,
  });

  final Int? width;
  final Int? height;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final Border? border;
  final Widget child;

  @override
  List<String> get classes {
    final builder = ClassBuilder(super.classes);
    builder.add("bg-{}", color);
    builder.add("{}", alignment);
    builder.addClassAll(margin?.getMarginClasses());
    builder.addClassAll(padding?.getPaddingClasses());
    builder.addClassAll(border?.getClasses());
    return builder.classes;
  }

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
