import 'package:flyer/generator/foundation.dart';

abstract class Widget {
  const Widget();

  StringBuffer render(RenderContext context) {
    return StringBuffer(build().render(context.copy));
  }

  Widget build() {
    return this;
  }

  run() {
    print(render(RenderContext()).toString());
  }
}

abstract class Component extends Widget {
  const Component();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

abstract class Layout extends Widget {
  const Layout({required this.content});

  final Widget content;

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

abstract class WebPage extends Widget {
  const WebPage();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}
