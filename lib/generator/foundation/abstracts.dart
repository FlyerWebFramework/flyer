import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
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
  const Slot.empty([this.name]);

  final String? name;

  @override
  StringBuffer render(RenderContext context) {
    return Render.slot(context, name: name);
  }
}

class Fragment extends Slot {
  const Fragment({required super.name, required this.child});

  final Widget child;

  StringBuffer renderFragment(RenderContext context) {
    return Render.fragment(context, name: name!, child: child.render(context.copy));
  }
}

abstract class Component extends Widget {
  const Component({this.child = const Slot()});

  Map<String, dynamic> get obs => {};

  Arguments get args => Arguments({});

  Scripts get scripts => Scripts({});

  List<Fragment> get fragments => [];

  final Widget child;

  @override
  Widget build() {
    throw UnimplementedError();
  }

  $<T> $argByName<T>(String name) => args.get(name);

  $<T> $arg<T>(T value) {
    hasSameValue(e) => e.value.toString() == value.toString();
    return $(value, name: args.list.entries.where(hasSameValue).first.key);
  }

  $<T> $var<T>(T value) => $(value);

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.webPath!, "src", "lib", "components"));
      final defaultFragment = child is Slot ? null : Fragment(name: Constants.defaultFragmentName, child: child);
      return Render.element(
        context,
        tag: runtimeType.toString(),
        custom: {...args.list},
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
    final properties = args.list.isNotEmpty ? "let { ${args.list.keys.join(', ')} } = \$props();\n\n" : "";
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

class Layout extends Component {
  const Layout({this.content = const Slot.empty()});

  final Widget content;

  @override
  Widget build() {
    return content;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.list([
      build().render(context.copy),
      Render.element(
        context,
        tag: "script",
        child: Render.text(
          context.copy,
          "import '/src/app.css';",
        ),
      ),
    ]);
  }

  @override
  generate({bool debug = false, required String outputPath}) {
    if (!exists(outputPath)) createDir(outputPath);
    final layoutPage = render(RenderContext(slot: true)).toString();
    File(path.join(outputPath, '+layout.svelte')).writeAsStringSync(layoutPage);
  }
}
