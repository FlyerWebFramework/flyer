extension UnitsExtension on num {
  Unit get px => Unit(value: this, unit: UnitType.px);

  Unit get pt => Unit(value: this, unit: UnitType.pt);

  Unit get em => Unit(value: this, unit: UnitType.em);

  Unit get rem => Unit(value: this, unit: UnitType.rem);

  Unit get per => Unit(value: this, unit: UnitType.percent);
}

enum UnitType { px, pt, em, rem, percent, custom }

class Unit {
  const Unit({required this.value, required this.unit});

  final num value;

  final UnitType unit;

  @override
  String toString() {
    switch (unit) {
      case UnitType.px:
      case UnitType.pt:
      case UnitType.em:
      case UnitType.rem:
        return "$value${unit.name}";
      case UnitType.percent:
        return "$value%";
      case UnitType.custom:
        return value.toString();
    }
  }
}

class Variable<T> {
  final String? name;
  final T value;

  const Variable(this.value, {this.name});

  factory Variable.create({required T value, required String name}) {
    return Variable<T>(value, name: name);
  }

  @override
  String toString() {
    return name != null ? "{$name}" : "$value";
  }
}

class $<T> extends Variable<T> {
  $(super.value, {super.name});
}

extension Var<T> on T {
  $<T> get v => $(this);
}