import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class WebSite extends Widget {
  const WebSite({
    this.title,
    this.author,
    this.description,
    this.keywords,
    this.charset = 'utf-8',
    this.refresh,
    required this.routes,
  });

  // TODO:
  // final Theme theme;
  // final Favicon icon;
  // final Url baseUrl;

  final String? title;
  final String? author;
  final String? description;
  final String? charset;
  final Duration? refresh;
  final List<String>? keywords;

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
          child: Render.list([
            Render.meta(context.indent(2), charset: charset),
            if (title != null)
              Render.element(
                context.indent(3),
                tag: "title",
                child: Render.text(context.indent(3), title!),
                newLine: true,
                oneLine: true,
              ),
            Render.link(context.indent(2), rel: "icon", href: "%sveltekit.assets%/favicon.png"),
            if (author != null) Render.meta(context.indent(2), name: "author", content: author),
            if (description != null) Render.meta(context.indent(2), name: "description", content: description),
            if (keywords != null) Render.meta(context.indent(2), name: "keywords", content: keywords!.join(", ")),
            if (refresh != null) Render.meta(context.indent(2), httpEquiv: "refresh", content: "${refresh!.inSeconds}"),
            Render.meta(context.indent(2), name: "viewport", content: "width=device-width, initial-scale=1"),
            Render.text(context.indent(2), "%sveltekit.head%"),
          ]),
        ),
        Render.newLine,
        Render.element(
          context.indent(2),
          tag: 'body',
          custom: {"data-sveltekit-preload-data": "hover"},
          child: Render.element(
            context.indent(3),
            tag: "div",
            styles: {"display": "contents"},
            child: Render.text(context.indent(3), "%sveltekit.body%"),
          ),
        )
      ]),
    );
  }
}
