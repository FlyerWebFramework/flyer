import 'package:flyer/flyer.dart';

import 'pages/index_page.dart';

void main(List<String> arguments) {
  WebSite(
    title: "Flyer example",
    routes: {
      "/": IndexPage(),
    },
  ).generate(debug: true, outputPath: arguments.first);
}

generate(WebSite widget) {
  print(widget.render(RenderContext()));
}
