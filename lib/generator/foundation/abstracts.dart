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

  generateClass(String template, Variable? variable) {
    final genClassesPath = path.join(Constants.webPath!, "src", "lib", "index.js");
    if (variable != null) {
      final classLine = template.replaceAll("{}", variable.value.toString());
      final indexContent = File(genClassesPath).readAsStringSync();
      if (!indexContent.contains(classLine)) {
        genClassesPath.append("// $classLine");
      }

      return template.replaceAll("{}", variable.toString());
    }
  }

  generate({bool debug = false, required String outputPath}) async {
    throw UnimplementedError();
  }
}

class Slot extends Widget {
  const Slot();

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(context.copy, tag: 'slot', oneLine: true);
  }
}

abstract class Component extends Widget {
  const Component({this.child = const Slot()});

  Map<String, dynamic> get obs => {};

  Props get props => Props([]);

  Scripts get scripts => Scripts({});

  final Widget child;

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.webPath!, "src", "lib", "components"));
      return Render.element(
        context,
        tag: runtimeType.toString(),
        custom: {...props.list},
        child: child is Slot ? null : child.render(context.copy),
      );
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
    final properties = "let { ${props.list.keys.join(', ')} } = \$props();";
    final variables = obs.entries.map((e) => "let ${e.key} = \$state(${e.value});\n").join("");
    final functions = scripts.list.entries.map((e) => "function ${e.key}${e.value}\n\n").join("");
    return "<script>\n$properties\n$variables\n$functions</script>\n\n";
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
