import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Text extends Widget {
  const Text(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'span',
      classes: style?.classes,
      child: Render.text(context, text),
    );
  }
}
