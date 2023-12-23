import 'dart:io';

import 'package:flyer/generator/core/render.dart';
import 'package:flyer/generator/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:flyer/generator/foundation.dart';

abstract class Widget {
  const Widget();

  StringBuffer render(RenderContext context) {
    if (context.slot) {
      return Render.text(context, "<slot/>");
    } else {
      return build().render(context.copy);
    }
  }

  Widget build() {
    return this;
  }

  generate({bool debug = false, required String outputPath}) {
    throw UnimplementedError();
  }
}

abstract class Component extends Widget {
  const Component();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

abstract class Layout extends Widget {
  const Layout({required this.content});

  final Page content;

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  StringBuffer render(RenderContext context) {
    return build().render(context);
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    final page = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+layout.svelte')).writeAsStringSync(page);
    File(path.join(outputPath, '+page.svelte')).writeAsStringSync(content.render(RenderContext()).toString());
    return true;
  }
}

abstract class WebPage extends Widget {
  const WebPage();

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    final result = build().generate(outputPath: outputPath);
    if (result != true) {
      final page = render(RenderContext()).toString();
      File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
    }
  }
}
