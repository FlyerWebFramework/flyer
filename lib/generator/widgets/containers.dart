import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final $<EdgeInsets> padding;
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

  final $<Unit>? width;
  final $<Unit>? height;

  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("w-{}", width);
    builder.add("h-{}", height);
    return builder.classes;
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

  final $<Color>? color;
  final $<EdgeInsets?>? padding;
  final $<Alignment?>? alignment;
  final $<Decoration?>? decoration;
  final Widget child;

  @override
  List<String> get classes {
    final builder = ClassBuilder(super.classes);
    builder.add("bg-{}", color);
    builder.add("{}", alignment);
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

class Wrap extends Widget {
  const Wrap({required this.children});

  final List<Widget> children;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list(children.map((e) => e.render(context)).toList());
  }
}
