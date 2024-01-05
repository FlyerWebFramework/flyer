import 'package:flyer/widgets.dart';

import '../components/simple_article.dart';
import '../components/simple_button.dart';
import '../components/simple_rectangle.dart';

class IndexPage extends WebPage {
  const IndexPage();

  @override
  Widget build() {
    return Page(
      content: Container(
        alignment: $(Align.center),
        child: SizedBox(
          width: $(50.per),
          child: Column(
            alignment: $(Alignment.center),
            spacing: $(1.rem),
            children: [
              Container(
                width: $(Unit(value: "50vw", unit: UnitType.custom)),
                height: $(Unit(value: "50vh", unit: UnitType.custom)),
                padding: $(EdgeInsets.all(2.rem)),
                color: $(Color.blue.shade300),
                border: $(Border.all(width: 1.rem, color: Color.red)),
                child: Grid(
                  columns: $(12),
                  spacing: $(1.rem),
                  alignment: $(Alignment.center),
                  children: [
                    for (var i in List.generate(18, (index) => index))
                      ...() {
                        return [
                          SimpleRectangle(size: 50.px, color: Color.red),
                          SimpleRectangle(size: 50.px, color: Color.green.shade700),
                          SimpleRectangle(size: 50.px, color: Color.green.shade700),
                          SimpleRectangle(size: 50.px, color: Color.green.shade700),
                        ];
                      }()
                  ],
                ),
              ),
              Text("Header".v),
              Title("Nadpis".v),
              Svg.asset("logo.svg", size: Size(15.rem, 5.rem)),
              Svg.url(Uri.parse("https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/atom.svg")),
              Image.url(
                Uri.parse("https://www.creativefabrica.com/wp-content/uploads/2022/12/06/"
                    "Rudolph-Reindeer-Christmas-PNG-Clipart-Graphics-50726285-1-1-580x387.png"),
                size: Size(50.per, 50.per),
              ),
              Paragraph(children: [
                Text(
                  $("Text123"),
                  style: TextStyle(
                    color: $(Color.black),
                    decoration: $(TextDecoration.underline),
                  ),
                ),
                Text(
                  $("Text123"),
                  style: TextStyle(
                    color: $(Color.black),
                    fontSize: $(20.pt),
                    fontWeight: $(FontWeight.bold),
                  ),
                ),
                Text(
                  $("Text123"),
                  style: TextStyle(
                    color: $(Color.blue),
                    fontSize: $(16.pt),
                  ),
                ),
              ]),
              Text("Some text".v),
              SimpleButton(size: SimpleSize(300.px, 70.px), disabled: Bool(true)),
              SimpleButton(size: SimpleSize(500.px, 100.px)),
              SimpleRectangle(size: 50.px),
              SimpleRectangle(size: 100.px, align: Align.centerRight, child: Text("Test123".v)),
              SimpleRectangle(size: 150.px, align: Align.center, child: Text("Test123".v)),
              SimpleRectangle(size: 200.px),
              SimpleArticle(
                header: Fragment(name: "header", child: Text("This is title".v)),
                content: Fragment(name: "content", child: Text("Here is some text".v)),
                footer: Fragment(name: "footer", child: Text("This is end of article".v)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
