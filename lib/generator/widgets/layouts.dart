import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Align extends Widget {
  const Align({required this.alignment, required this.child});

  final Alignment alignment;
  final Widget child;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClass("flex");
    builder.addClass(alignment.toString());
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

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final EdgeInsets padding;
  final Widget child;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClassAll(padding.getPaddingClasses());
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

  final Unit? width;
  final Unit? height;
  final Widget? child;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("w-{}", width ?? Str('full'));
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
    this.alignment,
    required super.child,
  });

  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final Border? border;

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
    this.width,
  });

  final Alignment? alignment;
  final Unit? spacing;
  final Unit? width;

  final List<Widget> children;

  @override
  List<String> get classes {
    final builder = ClassBuilder(['grid', 'grid-col']).add("gap-{}", spacing).add("{}", alignment);
    builder.add("w-{}", width ?? Str('full'));
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
    this.mainRowAlignment,
    this.crossRowAlignment,
    this.spacing,
  })  : wrap = true,
        full = false;

  const Row.nowrap({
    required this.children,
    this.mainRowAlignment,
    this.crossRowAlignment,
    this.spacing,
  })  : wrap = false,
        full = false;

  const Row.full({
    required this.children,
    this.mainRowAlignment,
    this.crossRowAlignment,
    this.spacing,
  })  : wrap = true,
        full = true;

  final MainRowAlignment? mainRowAlignment;
  final CrossRowAlignment? crossRowAlignment;
  final Unit? spacing;
  final bool? wrap;
  final bool? full;

  final List<Widget> children;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClass("flex ${wrap == true ? 'flex-wrap' : 'flex-nowrap'}");
    if (full == true) builder.addClass("w-full");
    builder.add("{}", mainRowAlignment);
    builder.add("{}", crossRowAlignment);
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

class Spacer extends Widget {
  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: ['flex', 'flex-wrap', 'grow'],
    );
  }
}

class Grid extends Widget {
  const Grid({
    required this.children,
    this.alignment,
    this.spacing,
    this.rows = 1,
    this.columns = 1,
  });

  final Alignment? alignment;
  final Unit? spacing;
  final int rows;
  final int columns;

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
