library widgets;

export 'generator/widgets.dart';
export 'generator/foundation.dart';
export 'generator/core/annotations.dart';

T $prop<T>(T value) => value;

T $state<T>(T state) => state;

$derived(dynamic state) {}

$effect(Function() func) {}

$scripts(Map<Symbol, Function> scripts) {}
//$script({required Symbol name, required Function() function}) {}
$script(Symbol name, Function function) {}
