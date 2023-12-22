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
    return Render.element(
      context.copy,
      tag: 'html',
      child: Render.list([
        Render.element(
          context.indent(2),
          tag: 'head',
          child: Render.text(context.indent(2), "%sveltekit.head%"),
        ),
        Render.newLine,
        Render.element(
          context.indent(2),
          tag: 'body',
          child: Render.text(context.indent(2), "%sveltekit.body%"),
        )
      ]),
    );
  }
}
