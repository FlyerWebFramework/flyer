import 'package:flyer/widgets.dart';

import '../components/simple_button.dart';
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
            SimpleButton(),
          ],
        ),
      ),
    );
  }
}
