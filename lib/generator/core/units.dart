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
  const Var(this.variableValue, {this.parentName, this.currentName});

  final String? parentName;
  final String? currentName;
  final T variableValue;

  setName(String name) {
    return Var(variableValue, currentName: name, parentName: currentName);
  }

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();
}

class Unit extends Var {
  const Unit(super.value, {this.unit = UnitType.custom, super.parentName, super.currentName});

  final UnitType unit;

  const factory Unit.empty() = EmptyUnit;

  const factory Unit.num(num value) = Num;

  const factory Unit.int(int value) = Int;

  const factory Unit.double(double value) = Double;

  const factory Unit.bool(bool value) = Bool;

  const factory Unit.str(String value) = Str;

  @override
  String toString() {
    if (currentName != null) {
      return '{$currentName}';
    } else {
      String result = '<unknown>';
      switch (unit) {
        case UnitType.px:
        case UnitType.pt:
        case UnitType.em:
        case UnitType.rem:
          result = "$variableValue${unit.name}";
        case UnitType.percent:
          result = "$variableValue%";
        case UnitType.custom:
          result = variableValue.toString();
      }
      return '[$result]';
    }
  }

  @override
  Unit setName(String name) {
    return Unit(variableValue, currentName: name, parentName: currentName);
  }
}

class EmptyUnit implements Unit {
  const EmptyUnit({this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  String get variableValue => "";

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  EmptyUnit setName(String name) {
    return EmptyUnit(currentName: name, parentName: currentName);
  }
}

class Num implements Unit {
  const Num(this.variableValue, {this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  final num variableValue;

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  Num setName(String name) {
    return Num(variableValue, currentName: name, parentName: currentName);
  }
}

class Int implements Unit {
  const Int(this.variableValue, {this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  final int variableValue;

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  Int setName(name) {
    return Int(variableValue, currentName: name, parentName: currentName);
  }
}

class Double implements Unit {
  const Double(this.variableValue, {this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  final double variableValue;

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  Double setName(String name) {
    return Double(variableValue, currentName: name, parentName: currentName);
  }
}

class Bool implements Unit {
  const Bool(this.variableValue, {this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  final bool variableValue;

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  Bool setName(String name) {
    return Bool(variableValue, currentName: name, parentName: currentName);
  }
}

class Str implements Unit {
  const Str(this.variableValue, {this.currentName, this.parentName});

  @override
  final UnitType unit = UnitType.custom;

  @override
  final String variableValue;

  @override
  final String? currentName;

  @override
  final String? parentName;

  @override
  String toString() => currentName != null ? '{$currentName}' : variableValue.toString();

  @override
  Str setName(String name) {
    return Str(variableValue, currentName: name, parentName: currentName);
  }
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
