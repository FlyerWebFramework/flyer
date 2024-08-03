import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
import 'package:path/path.dart' as path;
import 'package:flyer/generator/foundation.dart';

import 'component.dart';
import 'fragment.dart';

class Layout extends Component {
  const Layout({this.content = const Slot.empty()});

  final Widget content;

  @override
  Widget build() {
    return content;
  }

  @override
  List<String> get classes => ['prose'];

  @override
  StringBuffer render(RenderContext context) {
    final content = build().render(context.indent(2));
    final template = Render.element(context, tag: 'span', classes: classes, child: content);
    final scripts = renderScript(context, imports: ["import '/src/app.css'"]);
    return Render.list([scripts, Render.emptySpace(), template]);
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    if (!exists(outputPath)) createDir(outputPath);
    final layoutPage = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+layout.svelte')).writeAsStringSync(layoutPage);
  }
}
