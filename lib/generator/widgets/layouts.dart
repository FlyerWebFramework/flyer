import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final $<EdgeInsets> padding;
  final Widget child;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClassAll(padding.value?.getPaddingClasses());
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

class SizedBox extends Widget {
  const SizedBox({
    this.width,
    this.height,
    this.child,
  });

  final $<Unit>? width;
  final $<Unit>? height;
  final Widget? child;

  @override
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
      child: child?.render(context.copy),
    );
  }
}

class Container extends SizedBox {
  const Container({
    super.width,
    super.height,
    this.color,
    this.margin,
    this.border,
    this.padding,
    this.align,
    required super.child,
  });

  final $<Color?>? color;
  final $<EdgeInsets?>? margin;
  final $<EdgeInsets?>? padding;
  final $<Align?>? align;
  final $<Border?>? border;

  @override
  List<String> get classes {
    final builder = ClassBuilder(super.classes);
    builder.add("bg-{}", color);
    builder.add("{}", align);
    builder.addClassAll(margin?.value?.getMarginClasses());
    builder.addClassAll(padding?.value?.getPaddingClasses());
    builder.addClassAll(border?.value?.getClasses());
    return builder.classes;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
      child: child!.render(context.copy),
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

class Column extends Widget {
  const Column({
    required this.children,
    this.alignment,
    this.spacing,
  });

  final $<Alignment?>? alignment;
  final $<Unit?>? spacing;

  final List<Widget> children;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("grid grid-col", $(1));
    builder.add("{}", alignment);
    builder.add("gap-{}", spacing);
    return builder.classes;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
      child: Render.list([
        ...children.map((e) => e.render(context.copy)),
      ]),
    );
  }
}

class Row extends Widget {
  const Row({
    required this.children,
    this.alignment,
    this.spacing,
  }) : wrap = true;

  const Row.nowrap({
    required this.children,
    this.alignment,
    this.spacing,
  }) : wrap = false;

  final $<Alignment?>? alignment;
  final $<Unit?>? spacing;
  final bool? wrap;

  final List<Widget> children;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClass("flex ${wrap == true ? 'flex-wrap' : 'flex-nowrap'}");
    builder.add("{}", alignment);
    builder.add("gap-{}", spacing);
    return builder.classes;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
      child: Render.list([
        ...children.map((e) => e.render(context.copy)),
      ]),
    );
  }
}

class Grid extends Widget {
  const Grid({
    required this.children,
    this.alignment,
    this.spacing,
    this.rows = const $(1),
    this.columns = const $(1),
  });

  final $<Alignment?>? alignment;
  final $<Unit?>? spacing;
  final $<int>? rows;
  final $<int>? columns;

  final List<Widget> children;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClass("grid");
    builder.add("grid-cols-{}", columns);
    builder.add("grid-rows-{}", rows);
    builder.add("{}", alignment);
    builder.add("gap-{}", spacing);
    return builder.classes;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: classes,
      child: Render.list([
        ...children.map((e) => e.render(context.copy)),
      ]),
    );
  }
}
