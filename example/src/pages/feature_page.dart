import 'package:flyer/widgets.dart';

import '../components/simple_article.dart';
import '../components/simple_button.dart';
import '../components/simple_rectangle.dart';

class FeaturePage extends WebPage {
  const FeaturePage();

  @override
  Widget build() {
    return Column(
      alignment: $(Alignment.center),
      spacing: $(1.rem),
      children: [
        Wrap(
          children: [
            Text(
              $("Text123"),
              style: TextStyle(
                color: $(Color.black),
                decoration: $(TextDecoration.underline),
              ),
              decoration: Decoration(
                margin: $(EdgeInsets.zero),
              ),
            ),
            Text(
              $("Text123"),
              style: TextStyle(
                color: $(Color.black),
                fontSize: $(20.pt),
                fontWeight: $(FontWeight.bold),
              ),
              decoration: Decoration(
                margin: $(EdgeInsets.zero),
              ),
            ),
            Text(
              $("Text123"),
              style: TextStyle(
                color: $(Color.blue),
                fontSize: $(16.pt),
              ),
              decoration: Decoration(
                margin: $(EdgeInsets.zero),
              ),
            ),
          ],
        ),
        Text("Some text".v),
        SimpleButton(size: SimpleSize(300.px, 70.px), disabled: Bool(true)),
        SimpleButton(size: SimpleSize(500.px, 100.px)),
        SimpleRectangle(size: 50.px),
        SimpleRectangle(size: 100.px, alignment: Alignment.center, child: Text("Test123".v)),
        SimpleRectangle(size: 150.px, alignment: Alignment.centerRight, child: Text("Test123".v)),
        SimpleRectangle(size: 200.px),
        SimpleArticle(
          header: Fragment(name: "header", child: Text("This is title".v)),
          content: Fragment(name: "content", child: Text("Here is some text".v)),
          footer: Fragment(name: "footer", child: Text("This is end of article".v)),
        ),
      ],
    );
  }
}
