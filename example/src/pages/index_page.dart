import 'package:flyer/flyer.dart';

import '../components/simple_button.dart';

class IndexPage extends WebPage {
  const IndexPage();

  @override
  Widget build() {
    return Box(
      style: BoxStyle([
        Style.size.width(200.px),
        Style.size.height(200.px),
        Style.border.all.width(0.5.rem),
        Style.border.all.color(Color.red.shade400),
        Style.border.top.color(Color.green.shade400),
        Style.border.right.color(Color.green.shade400),
        Style.border.bottomRight.radius(4.rem),
        Style.background.color(Color.blue.shade400),
        ...Style.size.set(width: 8.rem, height: 8.rem),
      ]),
      child: child,
    );
  }
}

/*
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
*/
