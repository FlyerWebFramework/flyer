import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final EdgeInsets padding;
  final Widget child;

  @override
  StringBuffer render(RenderContext context) {
    throw UnimplementedError();
  }
}

class SizedBox extends Widget {
  const SizedBox({this.width, this.height});

  final double? width;
  final double? height;

  @override
  StringBuffer render(RenderContext context) {
    throw UnimplementedError();
  }
}

class Container extends SizedBox {
  const Container({
    super.width,
    super.height,
    this.color,
    this.padding,
    this.alignment,
    this.decoration,
    required this.child,
  });

  final Color? color;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final Decoration? decoration;
  final Widget child;

  List<String> get classes {
    return [
      if (width != null) "w-[${width}px]",
      if (height != null) "h-[${height}px]",
      if (color != null) "bg-${color!.value}-${color!.shade}",
      if (alignment == Alignment.center) "grid place-content-center",
    ];
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
