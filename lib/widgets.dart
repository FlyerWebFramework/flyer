library widgets;

export 'generator/widgets.dart';
export 'generator/foundation.dart';
export 'generator/core/annotations.dart';
export 'generator/core/constants.dart';

T $prop<T>(T value) => value;

T $state<T>(T state) => state;

$derived(dynamic state) {}

$effect(Function() func) {}

$scripts(Map<Symbol, Function> scripts) {}
//$script({required Symbol name, required Function() function}) {}
$script(Symbol name, Function function) {}

class Prop<T> extends Obs<T> {
  const Prop(super.name, super.value);
}

class Obs<T> {
  const Obs(this.name, this.value);

  final Symbol name;
  final T? value;

  Obs<T> operator +(value) => this;

  Obs<T> operator -(value) => this;
}

class Comp<T> {
  const Comp(this.name, this.value);

  final Symbol name;
  final Function() value;
}

// class Script {
//   const Script(this.name, this.value);
//
//   final Symbol name;
//   final Function value;
// }
