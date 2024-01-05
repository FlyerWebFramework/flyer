import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Text extends Widget {
  const Text(this.text, {this.style});

  final $<String> text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    if (style == null) {
      return Render.text(context, text.value!, indent: 0);
    } else {
      return Render.element(
        context,
        tag: 'span',
        classes: style?.getClasses(),
        child: Render.text(context, text.value!),
      );
    }
  }
}

enum HeadlineSize { h1, h2, h3, h4, h5, h6 }

class Headline extends Widget {
  const Headline(this.text, {this.style, this.size = HeadlineSize.h1});

  final $<String> text;
  final TextStyle? style;
  final HeadlineSize size;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: size.name,
      classes: style?.getClasses(),
      oneLine: true,
      child: Render.text(context, text.value!),
    );
  }
}
