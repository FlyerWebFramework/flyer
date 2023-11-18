import 'package:widgets/widgets.dart';

abstract class Widget {
  const Widget();

  StringBuffer render();

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
  StringBuffer render() {
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
  StringBuffer render() {
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
  StringBuffer render() {
    StringBuffer buffer = StringBuffer();
    buffer.write("<span ");
    if (onTap != null) buffer.write("on:click={${onTap!.name}");
    buffer.write(">\n");
    buffer.write(child.render());
    buffer.write("\n</span>");
    return buffer;
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
  StringBuffer render() {
    StringBuffer buffer = StringBuffer();
    buffer.write("<div ");
    if (classes.isNotEmpty) buffer.write("class='${classes.join(" ")}'");
    buffer.write(">\n");
    buffer.write(child.render());
    buffer.write("\n</div>");
    return buffer;
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
  StringBuffer render() {
    StringBuffer buffer = StringBuffer();
    buffer.write("\t<span ");
    if (style != null) buffer.write("class='${style!.classes.join(" ")}'");
    buffer.write(">\n\t\t");
    buffer.write(text);
    buffer.write("\n\t</span>");
    return buffer;
  }

  @override
  Widget build() {
    throw "Not Implemented";
  }
}
