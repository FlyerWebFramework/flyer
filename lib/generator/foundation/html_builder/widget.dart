import 'package:flyer/generator/foundation.dart';

abstract class Widget {
  const Widget();

  List<String> get classes => [];

  Widget build() {
    return this;
  }

  StringBuffer render(RenderContext context) {
    return build().render(context.copy);
  }

  generate({bool debug = false, required String outputPath}) async {
    throw UnimplementedError();
  }
}

class WidgetBuilder extends Widget {
  final StringBuffer Function(RenderContext) builder;

  WidgetBuilder({required this.builder});

  @override
  StringBuffer render(RenderContext context) => builder(context);
}

