library widgets;

export 'widgets/mixins.dart';
export 'widgets/widgets.dart';
export 'widgets/annotations.dart';
export 'widgets/foundation/border.dart';
export 'widgets/foundation/edge_insets.dart';
export 'widgets/foundation/text_style.dart';
export 'widgets/foundation/common.dart';


T $prop<T>(T value) => value;

T $state<T>(T state) => state;

$derived(dynamic state) {}

$effect(Function() func) {}

$scripts(Map<Symbol, Function> scripts) {}
//$script({required Symbol name, required Function() function}) {}
$script(Symbol name, Function function) {}

