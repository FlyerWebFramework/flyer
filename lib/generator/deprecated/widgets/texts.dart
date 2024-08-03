import 'package:flyer/flyer.dart';

enum HeadlineSize { h1, h2, h3, h4, h5, h6 }

sealed class TextWidget extends Widget {
  const TextWidget({this.style, this.decoration});

  final TextStyle? style;
  final Decoration? decoration;
}

class Text extends TextWidget {
  const Text(this.text, {super.style, super.decoration});

  final Str text;

  factory Text.newLine() => TextNewLine(''.str);

  StringBuffer renderTextTag(RenderContext context, String tag) {
    return Render.element(
      context,
      tag: tag,
      oneLine: true,
      styles: style?.getStyles(),
      classes: [...decoration?.getClasses() ?? [], ...style?.getClasses() ?? []],
      child: Render.text(context, text.variableValue),
    );
  }

  @override
  StringBuffer render(RenderContext context) {
    if (style == null) {
      return Render.text(context, text.variableValue, indent: 0);
    } else {
      return renderTextTag(context, 'span');
    }
  }
}

class TextNewLine extends Text {
  TextNewLine(super.text);

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(context, tag: 'br');
  }
}

class Title extends Text {
  const Title(super.text, {super.style, super.decoration, this.size = HeadlineSize.h1});

  final HeadlineSize size;

  @override
  StringBuffer render(RenderContext context) {
    return renderTextTag(context, size.name);
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
