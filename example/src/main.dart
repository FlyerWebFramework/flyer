import 'package:flyer/widgets.dart';

import 'pages/index_page.dart';

void main(List<String> arguments) {
  generate(
    WebSite(
      title: "Flyer example",
      routes: {
        "/": IndexPage(),
      },
    ),
  ); //.generate(debug: true, outputPath: arguments.first);
}

generate(WebSite widget) {
  print(widget.render(RenderContext()));
}
