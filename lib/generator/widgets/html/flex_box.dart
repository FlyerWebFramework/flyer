import 'package:flyer/flyer.dart';

enum DirectionType {
  horizontal,
  vertical,
}

class Direction implements Var {
  const Direction(this.type, {this.variableName});

  final DirectionType type;

  static Direction get horizontal => Direction(DirectionType.horizontal);

  static Direction get vertical => Direction(DirectionType.vertical);

  @override
  final String? variableName;

  @override
  String get variableValue => type.name;

  @override
  String toString() => variableValue.toString();

  Direction copyWith({
    DirectionType? type,
    String? variableName,
  }) {
    return Direction(
      type ?? this.type,
      variableName: variableName ?? this.variableName,
    );
  }
}

enum AlignmentType {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class Alignment implements Var {
  const Alignment(this.type, {this.variableName});

  final AlignmentType type;

  static Alignment get topLeft => Alignment(AlignmentType.topLeft);

  static Alignment get topCenter => Alignment(AlignmentType.topCenter);

  static Alignment get topRight => Alignment(AlignmentType.topRight);

  static Alignment get centerLeft => Alignment(AlignmentType.centerLeft);

  static Alignment get center => Alignment(AlignmentType.center);

  static Alignment get centerRight => Alignment(AlignmentType.centerRight);

  static Alignment get bottomLeft => Alignment(AlignmentType.bottomLeft);

  static Alignment get bottomCenter => Alignment(AlignmentType.bottomCenter);

  static Alignment get bottomRight => Alignment(AlignmentType.bottomRight);

  @override
  final String? variableName;

  @override
  String get variableValue => type.name;

  @override
  String toString() => variableValue.toString();
}

enum MainAlignmentType {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
  stretch,
}

class MainAlignment implements Var {
  const MainAlignment(this.type, {this.variableName});

  final MainAlignmentType type;

  static MainAlignment get start => MainAlignment(MainAlignmentType.start);

  static MainAlignment get end => MainAlignment(MainAlignmentType.end);

  static MainAlignment get center => MainAlignment(MainAlignmentType.center);

  static MainAlignment get spaceBetween => MainAlignment(MainAlignmentType.spaceBetween);

  static MainAlignment get spaceAround => MainAlignment(MainAlignmentType.spaceAround);

  static MainAlignment get spaceEvenly => MainAlignment(MainAlignmentType.spaceEvenly);

  static MainAlignment get stretch => MainAlignment(MainAlignmentType.stretch);

  String get cssValue {
    switch (type) {
      case MainAlignmentType.start:
        return "justify-start";
      case MainAlignmentType.end:
        return "justify-end";
      case MainAlignmentType.center:
        return "justify-center";
      case MainAlignmentType.spaceBetween:
        return "justify-between";
      case MainAlignmentType.spaceAround:
        return "justify-around";
      case MainAlignmentType.spaceEvenly:
        return "justify-evenly";
      case MainAlignmentType.stretch:
        return "justify-stretch";
    }
  }

  @override
  final String? variableName;

  @override
  String get variableValue => type.name;
}

enum CrossAlignmentType {
  start,
  end,
  center,
  stretch,
}

class CrossAlignment implements Var {
  const CrossAlignment(this.type, {this.variableName});

  final CrossAlignmentType type;

  static CrossAlignment get start => CrossAlignment(CrossAlignmentType.start);

  static CrossAlignment get end => CrossAlignment(CrossAlignmentType.end);

  static CrossAlignment get center => CrossAlignment(CrossAlignmentType.center);

  static CrossAlignment get stretch => CrossAlignment(CrossAlignmentType.stretch);

  String get cssValue {
    switch (type) {
      case CrossAlignmentType.start:
        return "items-start";
      case CrossAlignmentType.end:
        return "items-end";
      case CrossAlignmentType.center:
        return "items-center";
      case CrossAlignmentType.stretch:
        return "items-stretch";
    }
  }

  @override
  final String? variableName;

  @override
  String get variableValue => type.name;
}

class FlexBox extends Widget {
  const FlexBox({
    this.style,
    this.spacing,
    this.mainAlignment,
    this.crossAlignment,
    required this.direction,
    required this.children,
  });

  final Unit? spacing;
  final BoxStyle? style;
  final Direction direction;
  final List<Widget> children;
  final MainAlignment? mainAlignment;
  final CrossAlignment? crossAlignment;

  @override
  List<String> get classes => style?.classes ?? [];

  List<String> get directionClass => [
        'flex',
        if (direction.type == Direction.horizontal.type) 'flex-row',
        if (direction.type == Direction.vertical.type) 'flex-col',
      ];

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'div',
      classes: [
        ...classes,
        ...directionClass,
        if (spacing != null) 'gap-$spacing',
        mainAlignment?.cssValue ?? '',
        crossAlignment?.cssValue ?? '',
      ],
      child: Render.list(children.map((e) => e.render(context)).toList()),
    );
  }
}
