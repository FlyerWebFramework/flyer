import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/widgets.dart';

import 'pages/index.dart';

void main(List<String> arguments) {
  WebSite(
    title: "Flyer example",
    routes: {
      "/": IndexPage(),
    },
  ).generate(debug: true, outputPath: Constants.outputPath);
}
