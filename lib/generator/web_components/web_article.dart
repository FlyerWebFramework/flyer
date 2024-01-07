import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';
import 'package:flyer/generator/widgets/texts.dart';

class Header extends Widget {
  const Header({required this.title, this.description = const []});

  final Widget title;
  final List<Text> description;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'header',
      child: Render.list([
        title.render(context.copy),
        ...description.map((e) => e.render(context.copy)),
      ]),
    );
  }
}

class Footer extends Widget {
  const Footer({required this.content});

  final List<Text> content;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'footer',
      child: Render.list([...content.map((e) => e.render(context.copy))]),
    );
  }
}

class Article extends Widget {
  const Article({required this.header, required this.content, this.footer});

  final Header header;
  final List<Text> content;
  final Footer? footer;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'article',
      child: Render.list([
        header.render(context.copy),
        ...content.map((e) => e.render(context.copy)),
        footer?.render(context.copy) ?? StringBuffer(),
      ]),
    );
  }
}
