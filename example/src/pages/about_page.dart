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
        Paragraph(children: [Text($("* Paragraph 1"))]),
        Paragraph(children: [Text($("* Paragraph 2"))]),
      ],
    );
  }
}
