import 'package:flyer/widgets.dart';

import '../components/simple_article.dart';
import '../components/simple_button.dart';
import '../components/simple_rectangle.dart';
import '../layouts/default_layout.dart';

class IndexPage extends WebPage {
  IndexPage();

  @override
  Widget build() {
    return DefaultLayout(
      content: Page(
        content: Wrap(
          children: [
            Text("Header"),
            Text("Some text"),
            Text("<br>"),
            SimpleButton(size: Size(300.px, 70.px)),
            Text("<br>"),
            Text("<br>"),
            SimpleButton(size: Size(500.px, 100.px)),
            Text("<br>"),
            Text("<br>"),
            SimpleRectangle(size: 50.px),
            Text("<br>"),
            SimpleRectangle(size: 100.px),
            Text("<br>"),
            SimpleRectangle(size: 150.px, child: Text("Test123")),
            Text("<br>"),
            SimpleRectangle(size: 200.px),
            Text("<br>"),
            SimpleArticle(
              header: Fragment(name: "header", child: Text("This is title")),
              content: Fragment(name: "content", child: Text("Here is some text")),
              footer: Fragment(name: "footer", child: Text("This is end of article")),
            ),
          ],
        ),
      ),
    );
  }
}
