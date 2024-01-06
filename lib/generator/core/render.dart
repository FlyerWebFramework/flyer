import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Render {
  static StringBuffer meta(
    RenderContext context, {
    String? name,
    String? content,
    String? charset,
    String? httpEquiv,
  }) {
    final indentation = Constants.indent * (context.indentation + 1);
    return StringBuffer([
      "$indentation<meta",
      if (charset != null) "charset='$charset'",
      if (httpEquiv != null) "http-equiv='$httpEquiv'",
      if (name != null) "name='$name'",
      if (content != null) "content='$content'",
    ].join(" "))
      ..write(">");
  }

  static StringBuffer link(RenderContext context, {required String rel, required String href}) {
    final indentation = Constants.indent * (context.indentation + 1);
    return StringBuffer([
      "$indentation<link",
      "rel='$rel'",
      "href='$href'",
    ].join(" "))
      ..write(">");
  }

  static StringBuffer text(RenderContext context, String text, {int indent = 1}) {
    return StringBuffer("${Constants.indent * (context.indentation + indent)}$text");
  }

  static StringBuffer emptySpace() {
    return StringBuffer("");
  }

  static StringBuffer slot(RenderContext context, {String? name, int indent = 0}) {
    final indentSpace = Constants.indent * (context.indentation + indent);
    return StringBuffer("$indentSpace<slot ${name != null ? "name='$name'" : ""}/>");
  }

  static StringBuffer fragment(RenderContext context, {required String name, required StringBuffer child}) {
    return Render.element(context, tag: "svelte:fragment", attributes: {"slot": name}, child: child);
  }

  static StringBuffer list(List<StringBuffer> elements) {
    return StringBuffer(elements.join("\n"));
  }

  static StringBuffer script(List<StringBuffer> lines) {
    if (lines.isEmpty) return StringBuffer();
    return Render.element(RenderContext(), tag: 'script', child: Render.list(lines));
  }

  static StringBuffer element(
    RenderContext context, {
    required String tag,
    List<Event>? events,
    List<String>? classes,
    StringBuffer? child,
    Map<String, String>? styles,
    Map<String, String>? attributes,
    bool newLine = false,
    bool oneLine = false,
  }) {
    final String indentation = Constants.indent * context.indentation;
    final StringBuffer buffer = StringBuffer();
    buffer.write("$indentation<$tag");
    if (events != null && events.isNotEmpty) {
      buffer.write(" ");
      for (Event event in events) {
        if (event.action == null) continue;
        buffer.write("on:${event.type.name}={${event.action?.name ?? (event.action?.value as Script?)?.name}}");
      }
    }
    if (classes != null && classes.isNotEmpty) {
      buffer.write(" ");
      buffer.write("class='");
      buffer.writeAll(classes, " ");
      buffer.write("'");
    }
    if (styles != null && styles.isNotEmpty) {
      buffer.write(" ");
      buffer.write("style='");
      buffer.write([for (var e in styles.entries) "${e.key}:${e.value}"].join(';'));
      buffer.write("'");
    }
    if (attributes != null && attributes.isNotEmpty) {
      buffer.write(" ");
      buffer.write([for (var e in attributes.entries) "${e.key}='${e.value}'"].join(' '));
    }
    if (child != null && child.isNotEmpty) {
      buffer.write(">");
      if (!oneLine) buffer.writeln();
      buffer.write(!oneLine ? child : child.toString().trim());
      if (!oneLine) buffer.writeln();
      buffer.write(!oneLine ? "$indentation</$tag>" : "</$tag>");
    } else {
      buffer.write("/>");
    }
    if (newLine) buffer.writeln();
    return buffer;
  }
}
