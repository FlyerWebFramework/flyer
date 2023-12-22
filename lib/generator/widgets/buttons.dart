import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';
import 'package:flyer/generator/widgets.dart';

class Button extends SizedBox with Gestures {
  Button({
    Script? onTap,
    super.width,
    super.height,
    this.color,
    this.decoration,
    required this.child,
  }) {
    this.onTap = onTap;
  }

  final Color? color;
  final Decoration? decoration;
  final Widget child;

  List<String> get classes {
    return [
      if (width != null) "w-[${width}px]",
      if (height != null) "h-[${height}px]",
      if (color != null) "bg-${color!.value}-${color!.shade}",
    ];
  }

  @override
  StringBuffer render(RenderContext context) {
    return Element.render(
      context,
      tag: 'button',
      events: events,
      classes: classes,
      child: child.render(context.copy),
    );
  }
}
