import 'package:flyer/widgets.dart';

class IndexPage extends WebPage {
  const IndexPage();

  @override
  Widget build() {
    return Column(
      alignment: Alignment.center,
      children: [
        Text("Header"),
        Title("Nadpis"),
      ],
    );
  }
}
