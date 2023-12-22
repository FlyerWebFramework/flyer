import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';

mixin Gestures on Widget {
  Script? onTap;

  List<Event> get events {
    return [
      if (onTap != null) Event(type: EventType.click, script: onTap),
    ];
  }
}

class GestureDetector extends Widget with Gestures {
  GestureDetector({Script? onTap, required this.child}) {
    this.onTap = onTap;
  }

  final Widget child;

  @override
  StringBuffer render(RenderContext context) {
    return Element.render(
      context,
      tag: 'div',
      events: events,
      child: child.render(context.copy),
    );
  }
}
