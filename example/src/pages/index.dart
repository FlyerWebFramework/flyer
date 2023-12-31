import 'package:flyer/widgets.dart';

import '../components/simple_article.dart';
import '../components/simple_button.dart';
import '../components/simple_rectangle.dart';

class IndexPage extends WebPage {
  IndexPage();

  @override
  Widget build() {
    return Page(
      content: Wrap(
        children: [
          Text("Header".v),
          Text("Some text".v),
          Text("<br>".v),
          SimpleButton(size: Size(300.px, 70.px)),
          Text("<br>".v),
          Text("<br>".v),
          SimpleButton(size: Size(500.px, 100.px)),
          Text("<br>".v),
          Text("<br>".v),
          SimpleRectangle(size: 50.px),
          Text("<br>".v),
          SimpleRectangle(size: 100.px, align: Alignment.centerRight, child: Text("Test123".v)),
          Text("<br>".v),
          SimpleRectangle(size: 150.px, align: Alignment.center, child: Text("Test123".v)),
          Text("<br>".v),
          SimpleRectangle(size: 200.px),
          Text("<br>".v),
          SimpleArticle(
            header: Fragment(name: "header", child: Text("This is title".v)),
            content: Fragment(name: "content", child: Text("Here is some text".v)),
            footer: Fragment(name: "footer", child: Text("This is end of article".v)),
          ),
        ],
      ),
    );
  }
}
