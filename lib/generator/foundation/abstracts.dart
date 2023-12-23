import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:flyer/generator/foundation.dart';

abstract class Widget {
  const Widget();

  StringBuffer render(RenderContext context) {
    return build().render(context.copy);
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

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.outputPath, "src", "components"));
      return Render.element(context, tag: runtimeType.toString());
    } else {
      return build().render(context.copy);
    }
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    final page = render(RenderContext(slot: true)).toString();

    if(!exists(outputPath)) createDir(outputPath);
    File(path.join(outputPath, '$runtimeType.svelte'))
      .writeAsStringSync(page);
    return true;
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
    return build().render(context.copy);
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    if(!exists(outputPath)) createDir(outputPath);
    final layoutPage = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+layout.svelte')).writeAsStringSync(layoutPage);

    final page = content.render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
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
      if(!exists(outputPath)) createDir(outputPath);
      final page = render(RenderContext()).toString();
      File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
    }
  }
}
