import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/foundation/common.dart';

class Constants {
  static const String indent = "  ";
  static String? webPath;
  static const String defaultFragmentName = "defaultFragment";
  static const String defaultFaviconUrl = '%sveltekit.assets%/favicon.png';
  static const String daisyPrefix = 'daisy-';
  static const String componentsImportTag = '{{import components}}';
  static const Size defaultSvgSize = Size(
    Unit(value: "5", unit: UnitType.rem),
    Unit(value: "5", unit: UnitType.rem),
  );
  static const Size defaultImageSize = Size(
    Unit(value: "100", unit: UnitType.percent),
    Unit(value: "100", unit: UnitType.percent),
  );
}
