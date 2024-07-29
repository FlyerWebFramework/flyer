extension UnitsExtension on num {
  Unit get px => Unit(value: toString(), unit: UnitType.px);

  Unit get pt => Unit(value: toString(), unit: UnitType.pt);

  Unit get em => Unit(value: toString(), unit: UnitType.em);

  Unit get rem => Unit(value: toString(), unit: UnitType.rem);

  Unit get per => Unit(value: toString(), unit: UnitType.percent);
}

enum UnitType { px, pt, em, rem, percent, custom }

class Unit extends Var {
  const Unit({required super.value, required this.unit});

  final UnitType unit;

  const factory Unit.empty() = EmptyUnit;

  @override
  String toString() {
    String result = '<unknown>';
    switch (unit) {
      case UnitType.px:
      case UnitType.pt:
      case UnitType.em:
      case UnitType.rem:
        result = "$value${unit.name}";
      case UnitType.percent:
        result = "$value%";
      case UnitType.custom:
        result = value;
    }
    return '[$result]';
  }
}

class EmptyUnit implements Unit {
  const EmptyUnit();

  @override
  final UnitType unit = UnitType.custom;

  @override
  String get value => "";

  @override
  String toString() => "";
}

class Var<T> extends Object {
  const Var({required this.value});

  final T value;

  @override
  String toString() => value.toString();
}

class Num extends Var<num> {
  const Num({required super.value});
}

class Int extends Var<int> {
  const Int({required super.value});
}

class Double extends Var<double> {
  const Double({required super.value});
}

class Bool extends Var<bool> {
  const Bool({required super.value});
}

class Str extends Var<String> {
  const Str({required super.value});
}

class Obj extends Var<Object> {
  const Obj({required super.value});
}

class Enum extends Var {
  const Enum({required super.value});
}

class Const extends Var {
  const Const({required super.value});
}
