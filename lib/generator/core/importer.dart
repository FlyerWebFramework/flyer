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