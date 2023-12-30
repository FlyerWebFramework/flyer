import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class WebSite extends Widget {
  const WebSite({
    this.title,
    this.author,
    this.description,
    this.keywords,
    this.charset = 'utf-8',
    this.language = 'en',
    this.refresh,
    this.baseUrl,
    required this.routes,
  });

  // TODO:
  // final Theme theme;
  // final Favicon icon;

  final Uri? baseUrl;
  final String? title;
  final String? author;
  final String? description;
  final String charset;
  final String language;
  final Duration? refresh;
  final List<String>? keywords;

  final Map<String, WebPage> routes;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list([
      Render.text(context, "<!doctype html>"),
      Render.element(
        context.copy,
        tag: 'html',
        custom: {"lang": language},
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
                  oneLine: true,
                ),
              if (baseUrl != null && baseUrl!.isAbsolute)
                Render.element(
                  context.indent(3),
                  tag: "base",
                  custom: {"href": baseUrl!.origin},
                  oneLine: true,
                ),
              Render.link(context.indent(2), rel: "icon", href: "%sveltekit.assets%/favicon.png"),
              if (author != null) Render.meta(context.indent(2), name: "author", content: author),
              if (description != null) Render.meta(context.indent(2), name: "description", content: description),
              if (keywords != null) Render.meta(context.indent(2), name: "keywords", content: keywords!.join(", ")),
              if (refresh != null)
                Render.meta(context.indent(2), httpEquiv: "refresh", content: "${refresh!.inSeconds}"),
              Render.meta(context.indent(2), name: "viewport", content: "width=device-width, initial-scale=1"),
              Render.text(context.indent(2), "%sveltekit.head%"),
            ]),
          ),
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
      ),
    ]);
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    Constants.webPath = outputPath;
    final htmlPage = render(RenderContext()).toString();
    File(path.join(outputPath, 'src', 'app.html')).writeAsStringSync(htmlPage);

    for (MapEntry<String, WebPage> route in routes.entries) {
      final pagePath = path.join(outputPath, 'src', 'routes', route.key == '/' ? '' : route.key);
      route.value.generate(outputPath: pagePath);
    }
  }
}
