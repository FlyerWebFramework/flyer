extension UnitsExtension on num {
  Unit get px => Unit(value: toString(), unit: UnitType.px);

  Unit get pt => Unit(value: toString(), unit: UnitType.pt);

  Unit get em => Unit(value: toString(), unit: UnitType.em);

  Unit get rem => Unit(value: toString(), unit: UnitType.rem);

  Unit get per => Unit(value: toString(), unit: UnitType.percent);
}

enum UnitType { px, pt, em, rem, percent, custom }

class Bool {
  const Bool(this.value);

  final bool value;

  @override
  String toString() {
    return "{$value}";
  }
}

class Unit {
  const Unit({required this.value, required this.unit, this.onlyValue = false});

  final String value;

  final UnitType unit;

  final bool onlyValue;

  const Unit.empty()
      : value = "",
        unit = UnitType.custom,
        onlyValue = false;

  const Unit.bool(bool value)
      : value = "{$value}",
        unit = UnitType.custom,
        onlyValue = false;

  @override
  String toString({bool? onlyValue}) {
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
    return onlyValue ?? this.onlyValue ? result : '[$result]';
  }
}

class Variable<T> {
  final String? name;
  final T? value;

  const Variable(this.value, {this.name});

  factory Variable.create({required T? value, required String name}) {
    return Variable<T>(value, name: name);
  }

  @override
  String toString() {
    return name != null ? "{$name}" : "$value";
  }
}

class $<T> extends Variable<T> {
  const $(super.value, {super.name});
}

extension Var<T> on T {
  $<T> get v => $(this);
}
