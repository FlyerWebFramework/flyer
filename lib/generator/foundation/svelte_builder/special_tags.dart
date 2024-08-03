import 'package:flyer/generator/foundation/html_builder/context.dart';
import 'package:flyer/generator/foundation/html_builder/render.dart';
import 'package:flyer/generator/foundation/html_builder/widget.dart';

class $for<T, S> extends Widget {
  final int iterations;
  final List<Widget> children;

  $for({
    required this.iterations,
    required this.children,
  });

  @override
  StringBuffer render(RenderContext context) {
    return Render.list([
      Render.text(context, "{#each Array($iterations) as item, index}", indent: 0),
      ...children.map((e) => e.render(context.copy)),
      Render.text(context, "{/each}", indent: 0),
    ]);
  }
}
