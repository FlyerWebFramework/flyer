import 'package:flyer/widgets.dart';

class AboutPage extends WebPage {
  const AboutPage();

  @override
  Widget build() {
    return Container(
      padding: $(EdgeInsets.only(bottom: 10.rem, top: 6.rem)),
      alignment: $(Alignment.center),
      child: Article(
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
      ),
    );
  }
}
