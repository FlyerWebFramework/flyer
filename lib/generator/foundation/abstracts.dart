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


class Slot extends Widget {
  const Slot({this.name = Constants.defaultFragmentName});

  final String name;

  @override
  StringBuffer render(RenderContext context) {
    return Render.slot(context, name: name);
  }
}

class Fragment extends Slot {
  const Fragment({required super.name, required this.child});

  final Widget child;

  StringBuffer renderFragment(RenderContext context) {
    return Render.fragment(context, name: name, child: child.render(context.copy));
  }
}

abstract class Component extends Widget {
  const Component({this.child = const Slot()});

  Map<String, dynamic> get obs => {};

  Props get props => Props([]);

  Scripts get scripts => Scripts({});

  List<Fragment> get fragments => [];

  final Widget child;

  @override
  Widget build() {
    throw UnimplementedError();
  }

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.webPath!, "src", "lib", "components"));
      final defaultFragment = child is Slot ? null : Fragment(name: Constants.defaultFragmentName, child: child);
      return Render.element(
        context,
        tag: runtimeType.toString(),
        custom: {...props.list},
        child: Render.list([
          if (defaultFragment != null) defaultFragment.renderFragment(context.copy),
          ...fragments.map((e) => e.renderFragment(context.copy)),
        ]),
      );
    } else {
      return build().render(context.copy);
    }
  }

  _generateExportLine(String outputPath) {
    final indexPath = path.join(outputPath, 'index.js');
    final exportLine = 'export {default as $runtimeType} from "\$lib/components/$runtimeType.svelte"';
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
    final properties = props.list.isNotEmpty ? "let { ${props.list.keys.join(', ')} } = \$props();\n\n" : "";
    final variables = obs.entries.map((e) => "let ${e.key} = \$state(${e.value});\n\n").join("");
    final functions = scripts.list.entries.map((e) => "function ${e.key}${e.value}\n\n").join("");
    return "<script>\n$properties$variables$functions</script>\n\n";
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
