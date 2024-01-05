import 'package:flyer/widgets.dart';

import 'layouts/default_layout.dart';
import 'pages/about_page.dart';
import 'pages/index.dart';

void main(List<String> arguments) {
  WebSite(
    title: "Flyer example",
    routes: {
      "/": IndexPage(),
      "/about": AboutPage(),
    },
    buildLayout: (content) => DefaultLayout(content: content),
  ).generate(debug: true, outputPath: arguments.first);
}
