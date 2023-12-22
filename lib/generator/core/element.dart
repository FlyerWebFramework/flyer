import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

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
