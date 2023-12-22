import 'package:flyer/generator/widgets.dart';

import 'components/simple_button.dart';
import 'pages/index.dart';

void main(List<String> arguments) {
  WebSite(
    title: "Flyer example",
    routes: {
      "/": IndexPage(),
    },
  ).run();
}
