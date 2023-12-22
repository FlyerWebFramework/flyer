import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class WebSite extends Widget {
  const WebSite({
    this.title,
    required this.routes,
  });

  // TODO:
  // final Theme theme;
  // final Favicon icon;
  // final List<Meta> meta;
  // final Url baseUrl;

  final String? title;

  final Map<String, Widget> routes;

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
