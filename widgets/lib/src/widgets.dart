import 'package:widgets/widgets.dart';

abstract class Widget {
  const Widget();
  Widget build(BuildContext context);
}

class Padding extends Widget {
  const Padding({required this.padding, required this.child});

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    throw "Not implemented";
  }
}

class SizedBox  extends Widget {
  SizedBox({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    throw "Not implemented";
  }
}

class Container extends Widget {
  const Container({this.padding, required this.child, this.decoration});

  final EdgeInsets? padding;
  final Decoration? decoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    throw "Not implemented";
  }
}

class Text extends Widget {
  const Text(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    throw "Not implemented";
  }
}
