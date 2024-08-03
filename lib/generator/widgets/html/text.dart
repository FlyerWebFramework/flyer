import 'package:flyer/flyer.dart';

sealed class TextWidget extends Widget {
  const TextWidget();
}

class Text extends TextWidget {
  const Text({required this.text, this.style, this.tag});

  factory Text.write(Str text) => Text(text: text);

  factory Text.writeln(Str text) => Text(text: Str('$text\n'));

  factory Text.newLine() => Text(text: '\n'.str);

  factory Text.span(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'span');

  factory Text.bold(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'b');

  factory Text.italic(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'i');

  factory Text.underline(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'u');

  factory Text.strike(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'strike');

  factory Text.quote(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'q');

  factory Text.link(Str text, {TextStyle? style}) => Text(text: text, style: style, tag: 'a');

  final Str text;
  final TextStyle? style;
  final String? tag;

  @override
  StringBuffer render(RenderContext context) {
    final child = Render.text(context, text.variableValue.replaceAll('\n', '<br/>'));

    if (tag != null && tag!.isNotEmpty) {
      return Render.element(
        context,
        tag: tag!,
        oneLine: true,
        classes: style?.classes,
        child: child,
      );
    }
    return child;
  }
}

class TextSpan extends Widget {
  const TextSpan({required this.text, this.style});

  final List<TextWidget> text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'span',
      classes: style?.classes,
      child: Render.list(text.map((e) => e.render(context)).toList()),
    );
  }
}

class TextParagraph extends Widget {
  const TextParagraph({required this.text, this.style});

  final List<TextWidget> text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'p',
      classes: style?.classes,
      child: Render.list(text.map((e) => e.render(context)).toList()),
    );
  }
}
