import 'package:flyer/flyer.dart';
import 'package:flyer/generator/widgets/html/flex_box.dart';

import '../components/simple_component.dart';

class IndexPage extends WebPage {
  const IndexPage();

  @override
  Widget build() {
    return VBox(
      mainAlignment: MainAlignment.center,
      crossAlignment: CrossAlignment.center,
      style: BoxStyle([
        Style.size.width(300.px),
        Style.size.height(500.px),
      ]),
      children: [
        SimpleComponent(color: Color.green),
        SimpleComponent(),
        VBox(
          crossAlignment: CrossAlignment.start,
          style: BoxStyle([Style.size.width(130.px)]),
          children: [
            TextParagraph(text: [
              Text.newLine(),
              Text.writeln('Hello world'.str),
              Text.underline(
                'Hello world'.str,
                style: TextStyle([
                  Style.background.color(Color.yellow.shade400),
                ]),
              ),
              Text.newLine(),
              Text.strike('Hello world'.str),
              Text.newLine(),
              Text.bold('Hello world'.str),
            ]),
          ],
        ),
      ],
    );
  }
}