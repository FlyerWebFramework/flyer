import 'package:flyer/flyer.dart';
import 'package:flyer/generator/widgets/html/flex_box.dart';

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
        Box(
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
        ),
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