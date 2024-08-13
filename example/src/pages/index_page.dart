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
      spacing: 2.rem,
      style: BoxStyle([
        Style.size.width(500.px),
        Style.size.height(800.px),
        Style.border.all.width(1.px),
      ]),
      children: [
        SimpleComponent(color: Color.blue.shade600),
        SimpleComponent(color: Color.gray.shade400, text: Str("Test1234")),
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