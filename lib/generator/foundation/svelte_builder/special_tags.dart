import 'package:flyer/flyer.dart';

class $for<T, S> extends Widget {
  $for({
    required this.iterations,
    required this.children,
  });

  final int iterations;
  final List<Widget> children;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list([
      Render.text(context, "{#each Array($iterations) as item, index}", indent: 0),
      ...children.map((e) => e.render(context.copy)),
      Render.text(context, "{/each}", indent: 0),
    ]);
  }
}

class $if extends Widget {
  $if({
    required this.condition,
    required this.block,
    this.elseBlock,
  });

  final Condition condition;
  final List<Widget> block;
  final List<Widget>? elseBlock;

  @override
  StringBuffer render(RenderContext context) {
    return Render.list([
      Render.text(context, "{#if $condition}", indent: 0),
      ...block.map((e) => e.render(context.indent())),
      if (elseBlock != null) Render.text(context, "{:else}", indent: 0),
      if (elseBlock != null) ...elseBlock!.map((e) => e.render(context.indent())),
      Render.text(context, "{/if}", indent: 0),
    ]);
  }
}

class Condition {
  const Condition(this.value);
  final String value;

  @override
  String toString() => value;

  factory Condition.isNotEmpty(Var variable) {
    if (variable is Str) {
      if (variable.currentName != null) {
        return Condition('${variable.currentName} !== ""');
      } else {
        return Condition('${variable.variableValue} !== ""');
      }
    }
    return Condition('Is not defined yet.');
  }
}