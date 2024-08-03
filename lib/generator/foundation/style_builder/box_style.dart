import 'tailwind_style.dart';
export 'tailwind_style.dart';
export 'style.dart';

class BoxStyle {
  const BoxStyle(List<TailwindStyle> styles) : _styles = styles;

  final List<TailwindStyle> _styles;

  List<String> get classes => _styles.map((e) => e.toString()).toList();

  @override
  String toString() {
    return classes.join(' ');
  }
}

class TextStyle {
  const TextStyle(List<TailwindStyle> styles) : _styles = styles;

  final List<TailwindStyle> _styles;

  List<String> get classes => _styles.map((e) => e.toString()).toList();

  @override
  String toString() {
    return classes.join(' ');
  }
}
