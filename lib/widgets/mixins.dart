import 'package:flyer/widgets.dart';

mixin Gestures on Widget {
  Script? onTap;

  List<Event> get events {
    return [
      if (onTap != null) Event(type: EventType.click, script: onTap),
    ];
  }
}

