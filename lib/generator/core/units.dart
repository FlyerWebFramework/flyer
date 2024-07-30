extension UnitsExtension on num {
  Unit get px => Unit(toString(), unit: UnitType.px);

  Unit get pt => Unit(toString(), unit: UnitType.pt);

  Unit get em => Unit(toString(), unit: UnitType.em);

  Unit get rem => Unit(toString(), unit: UnitType.rem);

  Unit get per => Unit(toString(), unit: UnitType.percent);
}

extension StringExtension on String {
  Str get str => Str(this);
}

enum UnitType { px, pt, em, rem, percent, custom }

class Var<T> extends Object {
  const Var(this.value);

  final T value;

  @override
  String toString() => value.toString();
}

class Unit extends Var {
  const Unit(super.value, {this.unit = UnitType.custom});

  final UnitType unit;

  const factory Unit.empty() = EmptyUnit;

  const factory Unit.num(num value) = Num;

  const factory Unit.int(int value) = Int;

  const factory Unit.double(double value) = Double;

  const factory Unit.bool(bool value) = Bool;

  const factory Unit.str(String value) = Str;

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

class Num implements Unit {
  const Num(this.value);

  @override
  final UnitType unit = UnitType.custom;

  @override
  final num value;

  @override
  String toString() => value.toString();
}

class Int implements Unit {
  const Int(this.value);

  @override
  final UnitType unit = UnitType.custom;

  @override
  final int value;

  @override
  String toString() => value.toString();
}

class Double implements Unit {
  const Double(this.value);

  @override
  final UnitType unit = UnitType.custom;

  @override
  final double value;

  @override
  String toString() => value.toString();
}

class Bool implements Unit {
  const Bool(this.value);

  @override
  final UnitType unit = UnitType.custom;

  @override
  final bool value;

  @override
  String toString() => value.toString();
}

class Str implements Unit {
  const Str(this.value);

  @override
  final UnitType unit = UnitType.custom;

  @override
  final String value;

  @override
  String toString() => value.toString();
}

class Obj extends Var<Object> {
  const Obj(super.value);
}

class Enum extends Var {
  const Enum(super.value);
}

class Const extends Var {
  const Const(super.value);
}
