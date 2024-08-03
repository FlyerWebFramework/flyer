import 'package:flyer/generator/core/units.dart';
import 'package:flyer/generator/deprecated/builders.dart';

class Constants {
  static const String indent = "  ";
  static String? webPath;
  static const String defaultFragmentName = "defaultFragment";
  static const String defaultFaviconUrl = '%sveltekit.assets%/favicon.png';
  static const String daisyPrefix = 'daisy-';
  static const String componentsImportTag = '{{import components}}';
  static const Size defaultSvgSize = Size(
    Unit(5, unit: UnitType.rem),
    Unit(5, unit: UnitType.rem),
  );
  static const Size defaultImageSize = Size(
    Unit(100, unit: UnitType.percent),
    Unit(100, unit: UnitType.percent),
  );
}
