import 'package:flyer/widgets.dart';

import '../components/simple_button.dart';

class IndexPage extends WebPage {
  const IndexPage();

  @override
  Widget build() {
    return Column(
      alignment: Alignment.center,
      children: [
        Text("Header".str),
        Title("Nadpis".str),
        SimpleButton(text: Str("Button1")),
        SimpleButton(text: Str("Button2"), color: Color.yellow),
        SimpleButton(text: Str("Button3"), color: Color.yellow, textColor: Color.green),
      ],
    );
  }
}
