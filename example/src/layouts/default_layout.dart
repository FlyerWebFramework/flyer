import 'package:flyer/widgets.dart';

import '../components/footer_section.dart';
import '../components/navigation_bar.dart';

class DefaultLayout extends Layout {
  DefaultLayout({required super.content});

  @override
  Widget build() {
    return Align(
      alignment: $(Alignment.center),
      child: Column(
        spacing: $(2.rem),
        width: $(75.per),
        children: [
          NavigationBar(height: 50.px),
          content,
          //FooterSection(color: Color.hex("#263238")),
          FooterSection(color: Color.yellow),
        ],
      ),
    );
  }
}
