import 'package:flyer/widgets.dart';

import 'layouts/default_layout.dart';
import 'pages/about_page.dart';
import 'pages/index_page.dart';
import 'pages/service_page.dart';

void main(List<String> arguments) {
  WebSite(
    title: "Flyer example",
    routes: {
      "/": IndexPage(),
      "/about": AboutPage(),
      "/service": ServicePage(),
    },
    buildLayout: (content) => DefaultLayout(content: content),
  ).generate(debug: true, outputPath: arguments.first);
}
