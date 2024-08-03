import 'package:flyer/generator/core/utils.dart';
import 'package:flyer/generator/foundation/svelte_builder/component.dart';

class RenderContext {
  RenderContext({this.indentation = -1, this.slot = false, String? internalId}) {
    _internalId = internalId ?? Utils.getRandomString(16);
  }

  final int indentation;
  final bool slot;
  late final String _internalId;

  importComponent(Component component) {
    ComponentImporter.instance.add(_internalId, component.runtimeType.toString());
  }

  String? get componentsImport => ComponentImporter.instance.getImport(_internalId);

  RenderContext copyWith({int? indentation, bool? slot, String? parentId}) {
    return RenderContext(
      indentation: indentation ?? this.indentation,
      slot: slot ?? this.slot,
      internalId: _internalId,
    );
  }

  RenderContext get copy {
    return copyWith(indentation: indentation + 1);
  }

  RenderContext indent([int num = 1]) {
    return copyWith(indentation: indentation + num);
  }

  RenderContext indentBack([int num = 1]) {
    return copyWith(indentation: indentation - num);
  }
}
