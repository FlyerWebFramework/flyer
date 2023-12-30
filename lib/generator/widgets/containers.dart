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
  const SizedBox({
    this.width,
    this.height,
  });

  final Variable<Unit>? width;
  final Variable<Unit>? height;

  List<String> get classes {
    return [
      generateClass("w-[{}]", width),
      generateClass("h-[{}]", height),
    ]..remove("");
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
    );
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

  @override
  List<String> get classes {
    return [
      ...super.classes,
      if (color != null) "bg-${color!.value}",
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

class Wrap extends Widget {
  const Wrap({required this.children});

  final List<Widget> children;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list(children.map((e) => e.render(context)).toList());
  }
}
