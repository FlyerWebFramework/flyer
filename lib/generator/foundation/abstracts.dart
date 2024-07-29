import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/generator/core.dart';
import 'package:path/path.dart' as path;
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

  String $arg<T>(T value) {
    hasSameValue(e) => e.value.hashCode == value.hashCode;
    return '{${args.list.entries.where(hasSameValue).first.key}}';
  }

  @override
  StringBuffer render(RenderContext context) {
    if (context.indentation >= 0 && context.slot) {
      generate(outputPath: path.join(Constants.webPath!, "src", "lib", "components"));
      final defaultFragment = child is Slot ? null : Fragment(name: Constants.defaultFragmentName, child: child);
      context.importComponent(this);
      return Render.element(
        context,
        tag: runtimeType.toString(),
        attributes: {...args.filteredList},
        child: Render.list([
          if (defaultFragment != null) defaultFragment.renderFragment(context.copy),
          ...fragments.map((e) => e.renderFragment(context.copy)),
        ]),
      );
    } else {
      final template = build().render(context.copyWith(indentation: 0, slot: true));
      final scripts = renderScript(context);
      return Render.list([scripts, Render.emptySpace(), template]);
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

  StringBuffer renderScript(RenderContext context, {List<String> imports = const []}) {
    final properties = args.list.isNotEmpty ? "let { ${args.list.keys.join(', ')} } = \$props();" : null;
    final variables = obs.entries.map((e) => "let ${e.key} = \$state(${e.value});").join("");
    final functions = scripts.list.entries.map((e) => "function ${e.key}${e.value.function}").join("");
    imports = [...imports, context.componentsImport ?? '']..remove('');

    return Render.script([
      if (imports.isNotEmpty) Render.text(context.copy, imports.join(';\n  ')),
      if (properties != null) Render.text(context.copy, properties),
      if (obs.isNotEmpty) Render.text(context.copy, variables),
      if (scripts.list.isNotEmpty) Render.text(context.copy, functions),
    ]);
  }

  @override
  generate({bool debug = false, required String outputPath}) async {
    final page = render(RenderContext(slot: true)).toString();

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
