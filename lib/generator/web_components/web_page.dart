import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/widgets/containers.dart';
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
    if (!exists(outputPath)) createDir(outputPath);
    final page = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
  }
}

class Page extends Component {
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
    return Wrap(children: [
      if (header != null) header!,
      content,
      if (header != null) footer!,
    ]);
  }

  @override
  StringBuffer render(RenderContext context) {
    return build().render(context.copy);
  }
}
