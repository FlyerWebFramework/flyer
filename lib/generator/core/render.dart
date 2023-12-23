import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Render {
  static StringBuffer get newLine => StringBuffer('\n');

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

  static StringBuffer text(RenderContext context, String text) {
    return StringBuffer("${Constants.indent * (context.indentation + 1)}$text");
  }

  static StringBuffer list(List<StringBuffer> elements) {
    return StringBuffer(elements.join("\n"));
  }

  static StringBuffer element(
    RenderContext context, {
    required String tag,
    List<Event>? events,
    List<String>? classes,
    StringBuffer? child,
    Map<String, String>? styles,
    Map<String, String>? custom,
    bool newLine = false,
    bool oneLine = false,
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
    if (styles != null) {
      buffer.write(" ");
      buffer.write("style='");
      buffer.write([for (var e in styles.entries) "${e.key}:${e.value}"].join(';'));
      buffer.write("'");
    }
    if (custom != null) {
      buffer.write(" ");
      buffer.write([for (var e in custom.entries) "${e.key}='${e.value}'"].join(' '));
    }
    buffer.write(">");
    if (!oneLine) buffer.writeln();
    if (child != null) buffer.write(!oneLine ? child : child.toString().trim());
    if (child != null && !oneLine) buffer.writeln();
    buffer.write(!oneLine ? "$indentation</$tag>" : "</$tag>");
    if (newLine) buffer.writeln();
    return buffer;
  }
}