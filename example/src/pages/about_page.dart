import 'package:flyer/widgets.dart';

class AboutPage extends WebPage {
  const AboutPage();

  @override
  Widget build() {
    return Article(
      header: Header(
        title: Title(
          $("Main header"),
          size: HeadlineSize.h1,
        ),
      ),
      content: [
        Text($("* Paragraph 1")),
        Text.newLine(),
        Text($("* Paragraph 2")),
      ],
    );
  }
}
