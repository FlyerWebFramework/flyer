import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:flyer/flyer.dart';
import 'package:path/path.dart' as path;

abstract class ArgsObject {
  List get args => [];

  Map<String, dynamic> toArgs();
}

class Arguments {
  Arguments([Map<String, Var>? args]) {
    if (args != null) {
      for (var arg in args.entries) {
        _args[arg.key] = arg.value.setName(arg.key);
      }
    }
  }

  final Map<String, Var> _args = {};

  Map<String, dynamic> get list => _args.map((key, value) => MapEntry(key, value.toString()));

  Map<String, String> get filteredList {
    return {
      for (MapEntry<String, Var?> arg in _args.entries)
        if (arg.value != null) ...{arg.key: arg.value!.parentName == null ? arg.value!.variableValue.toString() : '{${arg.value!.parentName}}'}
    };
  }

  Arguments add(String name, dynamic value) {
    _args[name] = value;
    return this;
  }

  Arguments addObject(ArgsObject object) {
    for (var arg in object.toArgs().entries) {
      _args[arg.key] = arg.value;
    }
    return this;
  }

  get(String key) {
    return _args[key];
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

  // String $arg<T>(T value) {
  //   hasSameValue(e) => e.value.hashCode == value.hashCode;
  //   return '{${args.list.entries.where(hasSameValue).first.key}}';
  // }

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

class ComponentImporter {
  ComponentImporter._init();

  final Map<String, Set<String>> _importComponents = {};

  static final ComponentImporter instance = ComponentImporter._init();

  void add(String id, String component) {
    if (!_importComponents.keys.contains(id)) _importComponents[id] = {};
    _importComponents[id]!.add(component);
  }

  String? getImport(String id) {
    final components = _importComponents[id];
    if (components == null || components.isEmpty) return null;
    return 'import {${components.join(', ')}} from "\$lib/components/index.js"';
  }
}
