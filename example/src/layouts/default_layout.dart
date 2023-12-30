import 'package:flyer/widgets.dart';

class DefaultLayout extends Layout {
  DefaultLayout({required super.content});

  @override
  Widget build() {
    return Wrap(children: [
      Text($("Navigation")),
      content,
      Text($("Footer")),
    ]);
  }
}