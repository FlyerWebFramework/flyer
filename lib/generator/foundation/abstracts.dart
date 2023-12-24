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

  generate({bool debug = false, required String outputPath}) async {
    throw UnimplementedError();
  }
}

abstract class Component extends Widget {
  const Component();

  Map<String, dynamic> get obs => {};

  Scripts get scripts => Scripts({});

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.webPath!, "src", "lib", "components"));
      return Render.element(context, tag: runtimeType.toString());
    } else {
      return build().render(context.copy);
    }
  }

  _generateExportLine(String outputPath) {
    final indexPath = path.join(outputPath, 'index.js');
    final exportLine = 'export {default as $runtimeType} from "\$lib/components/$runtimeType.svelte"\n';
    if (!exists(indexPath)) {
      indexPath.write(exportLine);
    } else {
      final indexContent = File(indexPath).readAsStringSync();
      if (!indexContent.contains(exportLine)) {
        indexPath.append(exportLine);
      }
    }
  }

  String renderScriptPart() {
    final variables = obs.entries.map((e) => "let ${e.key} = \$state(${e.value});\n").join("");
    final functions = scripts.list.entries.map((e) => "function ${e.key}${e.value}\n\n").join("");
    return "<script>\n$variables\n$functions</script>\n\n";
  }

  @override
  generate({bool debug = false, required String outputPath}) async {
    final page = renderScriptPart() + render(RenderContext(slot: true)).toString();

    if (!exists(outputPath)) createDir(outputPath);
    File(path.join(outputPath, '$runtimeType.svelte')).writeAsStringSync(page);

    _generateExportLine(outputPath);

    return true;
  }
}

abstract class Layout extends Component {
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
    if (!exists(outputPath)) createDir(outputPath);
    final layoutPage = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+layout.svelte')).writeAsStringSync(layoutPage);

    final page = content.render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
    return true;
  }
}

abstract class WebPage extends Component {
  const WebPage();

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    final result = build().generate(outputPath: outputPath);
    if (result != true) {
      if (!exists(outputPath)) createDir(outputPath);
      final page = render(RenderContext()).toString();
      File(path.join(outputPath, '+page.svelte')).writeAsStringSync(page);
    }
  }
}
