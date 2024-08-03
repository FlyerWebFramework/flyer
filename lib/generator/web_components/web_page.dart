import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:flyer/generator/foundation/svelte_builder/component.dart';
import 'package:flyer/generator/widgets/layouts.dart';
import 'package:path/path.dart' as path;
import 'package:flyer/generator/foundation.dart';

abstract class WebPage extends Component {
  const WebPage();

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    if (!dcli.exists(outputPath)) dcli.createDir(outputPath);
    final page = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
  }
}

class Page extends Widget {
  Page({
    this.header,
    required this.content,
    this.footer,
  });

  final Widget? header;
  final Widget content;
  final Widget? footer;

  @override
  Widget build() {
    return Column(children: [
      if (header != null) header!,
      content,
      if (header != null) footer!,
    ]);
  }
}
