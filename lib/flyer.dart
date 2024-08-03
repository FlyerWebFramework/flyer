library flyer;

export 'generator/core/constants.dart';
export 'generator/core/units.dart';
export 'generator/core/utils.dart';
export 'generator/core/colors.dart';

export 'generator/foundation/html_builder/render.dart';
export 'generator/foundation/html_builder/widget.dart';
export 'generator/foundation/html_builder/context.dart';
export 'generator/foundation/html_builder/common.dart';
export 'generator/foundation/style_builder/box_style.dart';
export 'generator/foundation/svelte_builder/component.dart';
export 'generator/foundation/svelte_builder/special_tags.dart';
export 'generator/foundation/svelte_builder/fragment.dart';
export 'generator/foundation/svelte_builder/layout.dart';

export 'generator/widgets/html/box.dart';
export 'generator/widgets/web/web_article.dart';
export 'generator/widgets/web/web_page.dart';
export 'generator/widgets/web/web_site.dart';

export 'generator/deprecated/widgets/buttons.dart';
export 'generator/deprecated/widgets/layouts.dart';
export 'generator/deprecated/widgets/images.dart';
export 'generator/deprecated/widgets/gestures.dart';
export 'generator/deprecated/widgets/texts.dart';
export 'generator/deprecated/edge_insets.dart';
export 'generator/deprecated/text_style.dart';
export 'generator/deprecated/alignment.dart';
export 'generator/deprecated/builders.dart';
export 'generator/deprecated/border.dart';

/*
T $prop<T>(T value) => value;

T $state<T>(T state) => state;

$derived(dynamic state) {}

$effect(Function() func) {}

$scripts(Map<Symbol, Function> scripts) {}
//$script({required Symbol name, required Function() function}) {}
$script(Symbol name, Function function) {}
 */
