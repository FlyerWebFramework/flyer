import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Page extends Widget {
  const Page({
    required this.content,
  });

  final Widget content;

  @override
  Widget build() {
    return content;
  }

  @override
  StringBuffer render(RenderContext context) {
    return StringBuffer(Element.render(
      context.copy,
      tag: 'html',
      child: StringBuffer()
        ..writeln(
          Element.render(
            context.indent(2),
            tag: 'head',
            child: StringBuffer()..writeln("%sveltekit.head%"),
          ),
        )
        ..writeln()
        ..write(
          Element.render(
            context.indent(2),
            tag: 'body',
            child: StringBuffer()..writeln("%sveltekit.body%"),
          ),
        ),
    ));
  }
}
