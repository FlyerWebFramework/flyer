import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

sealed class TextWidget extends Widget {
  const TextWidget({this.style});

  final TextStyle? style;
}

class Text extends TextWidget {
  const Text(this.text, {super.style});

  final $<String> text;

  StringBuffer renderTextTag(RenderContext context, String tag) {
    return Render.element(
      context,
      tag: tag,
      oneLine: true,
      classes: style?.getClasses(),
      child: Render.text(context, text.value!),
    );
  }

  @override
  StringBuffer render(RenderContext context) {
    if (style == null) {
      return Render.text(context, text.value!, indent: 0);
    } else {
      return renderTextTag(context, 'span');
    }
  }
}

enum HeadlineSize { h1, h2, h3, h4, h5, h6 }

class Title extends Text {
  const Title(super.text, {super.style, this.size = HeadlineSize.h1});

  final HeadlineSize size;

  @override
  StringBuffer render(RenderContext context) {
    return renderTextTag(context, size.name);
  }
}

class Paragraph extends TextWidget {
  const Paragraph({required this.children, super.style});

  final List<TextWidget> children;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'p',
      classes: style?.getClasses(),
      child: Render.list(children.map((e) => e.render(context.copy)).toList()),
    );
  }
}

class RichText extends Widget {
  const RichText({required this.children});

  final List<TextWidget> children;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list(children.map((e) => e.render(context.copy)).toList());
  }
}