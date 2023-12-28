import 'package:flyer/widgets.dart';

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
            SimpleButton(size: Size(300, 70)),
            Text("<br>"),
            Text("<br>"),
            SimpleButton(size: Size(500, 100)),
            Text("<br>"),
            Text("<br>"),
            SimpleRectangle(size: 50),
            Text("<br>"),
            SimpleRectangle(size: 100),
            Text("<br>"),
            SimpleRectangle(size: 150),
            Text("<br>"),
            SimpleRectangle(size: 200),
          ],
        ),
      ),
    );
  }
}
