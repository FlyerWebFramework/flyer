import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

class Page extends Component {
  const Page({
    required this.content,
  });

  final Widget content;

  @override
  Widget build() {
    return content;
  }

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      build().render(RenderContext(slot: true));
      return Render.slot(context);
    } else {
      return build().render(context.copy);
    }
  }
}
