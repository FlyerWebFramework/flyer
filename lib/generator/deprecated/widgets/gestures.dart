import 'package:flyer/flyer.dart';

mixin Gestures on Widget {
  Action? onTap;

  List<Event> get events {
    return [
      if (onTap != null && onTap! is Script) Event(type: EventType.click, action: onTap),
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
    return Render.element(
      context,
      tag: 'div',
      events: events,
      child: child.render(context.copy),
    );
  }
}
