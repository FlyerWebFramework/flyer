import 'package:widgets/src/constants.dart';
import 'package:widgets/widgets.dart';

abstract class Widget {
  const Widget();

  StringBuffer render(RenderContext context);

  Widget build();
}

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build() {
    throw "Not implemented";
  }

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
  Widget build() {
    throw "Not implemented";
  }

  @override
  StringBuffer render(RenderContext context) {
    throw UnimplementedError();
  }
}

class GestureDetector extends Widget {
  const GestureDetector({this.onTap, required this.child});

  final Script? onTap;
  final Widget child;

  @override
  Widget build() {
    throw "Not implemented";
  }

  @override
  StringBuffer render(RenderContext context) {
    return Tag('div', child: child.render(context.copy())).render(context);
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
      if (color != null) "bg-${color!.name}-500",
      if (alignment == Alignment.center) "grid place-content-center",
    ];
  }

  @override
  StringBuffer render(RenderContext context) {
    return Tag('div', classes: classes, child: child.render(context.copy())).render(context);
  }

  @override
  Widget build() {
    throw "Not implemented";
  }
}

class Text extends Widget {
  const Text(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    return Tag(
      'span',
      classes: style!.classes,
      child: StringBuffer(Constants.indent * (context.indentation + 1) + text),
    ).render(context);
  }

  @override
  Widget build() {
    throw "Not Implemented";
  }
}

class Tag {
  Tag(this.name, {this.classes, this.child});

  String name;
  List<String>? classes;
  StringBuffer? child;

  StringBuffer render(RenderContext context) {
    final String indentation = Constants.indent * context.indentation;
    final StringBuffer buffer = StringBuffer();
    buffer.write("$indentation<$name");
    if (classes != null) buffer.write(" ");
    if (classes != null) {
      buffer.write("class='");
      buffer.writeAll(classes!, " ");
      buffer.write("'");
    }
    buffer.write(">\n");
    if (child != null) buffer.write(child!);
    if (child != null) buffer.writeln();
    buffer.write("$indentation</$name>");
    return buffer;
  }
}
