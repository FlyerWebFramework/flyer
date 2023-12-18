import 'package:widgets/src/constants.dart';
import 'package:widgets/widgets.dart';

abstract class Widget {
  const Widget();

  StringBuffer render(RenderContext context) {
    return StringBuffer(build().render(context.copy));
  }

  Widget build() {
    return this;
  }

  run() {
    print(render(RenderContext()).toString());
  }
}

abstract class Component extends Widget {
  const Component();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

class WebPage extends Widget {
  const WebPage({required this.body});

  final Widget body;

  @override
  Widget build() {
    return body;
  }

  @override
  StringBuffer render(RenderContext context) {
    return StringBuffer(Element.render(
      context.copy,
      tag: 'html',
      child: StringBuffer()
        ..writeln(Element.render(
          context.indent(2),
          tag: 'head',
        ))
        ..writeln()
        ..write(
          Element.render(
            context.indent(2),
            tag: 'body',
            child: build().render(context.indent(2)),
          ),
        ),
    ));
  }
}

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

class GestureDetector extends Widget with Gestures {
  GestureDetector({Script? onTap, required this.child}){
    this.onTap = onTap;
  }

  final Widget child;

  @override
  StringBuffer render(RenderContext context) {
    return Element.render(
      context,
      tag: 'div',
      events: events,
      child: child.render(context.copy),
    );
  }
}

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
    return Element.render(
      context,
      tag: 'div',
      classes: classes,
      child: child.render(context.copy),
    );
  }
}

class Text extends Widget {
  const Text(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    return Element.render(
      context,
      tag: 'span',
      classes: style!.classes,
      child: StringBuffer(Constants.indent * (context.indentation + 1) + text),
    );
  }
}

class Element {
  static StringBuffer render(
    RenderContext context, {
    required String tag,
    List<Event>? events,
    List<String>? classes,
    StringBuffer? child,
  }) {
    final String indentation = Constants.indent * context.indentation;
    final StringBuffer buffer = StringBuffer();
    buffer.write("$indentation<$tag");
    if (events != null) {
      buffer.write(" ");
      for (Event event in events) {
        if (event.script == null) continue;
        final symbol = event.script!.name.toString();
        buffer.write("on:${event.type.name}={${symbol.substring(8, symbol.length - 2)}}");
      }
    }
    if (classes != null) {
      buffer.write(" ");
      buffer.write("class='");
      buffer.writeAll(classes, " ");
      buffer.write("'");
    }
    buffer.write(">\n");
    if (child != null) buffer.write(child);
    if (child != null) buffer.writeln();
    buffer.write("$indentation</$tag>");
    return buffer;
  }
}
