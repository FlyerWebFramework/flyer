import 'package:flyer/flyer.dart';

class Slot extends Widget {
  const Slot({this.name = Constants.defaultFragmentName});

  const Slot.empty([this.name]);

  final String? name;

  @override
  StringBuffer render(RenderContext context) {
    return Render.slot(context, name: name);
  }
}

class Fragment extends Slot {
  const Fragment({required super.name, required this.child});

  final Widget child;

  StringBuffer renderFragment(RenderContext context) {
    return Render.fragment(context, name: name!, child: child.render(context.copy));
  }
}
