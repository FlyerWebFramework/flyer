import 'border.dart';

enum Color { red, yellow, blue, green, black, white }

class BuildContext {}

class Decoration {
  const Decoration({required this.color, required this.border});

  final Color color;
  final Border border;
}

class BoxDecoration extends Decoration {
  BoxDecoration({required super.color, required super.border});
}
