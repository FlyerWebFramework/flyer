import 'package:flyer/widgets.dart';

import '../components/navigation_bar.dart';

class DefaultLayout extends Layout {
  DefaultLayout({required super.content});

  @override
  Widget build() {
    return Column(
      alignment: $(Alignment.center),
      spacing: $(7.rem),
      children: [
        NavigationBar(width: 1440.px, height: 50.px),
        Container(
          width: $(80.per),
          alignment: $(Alignment.center),
          child: content,
        ),
        Text($("Footer")),
      ],
    );
  }
}
