/*
enum Align {
  topLeft("grid items-start justify-items-start"),
  topCenter("grid items-start justify-items-center"),
  topRight("grid items-start justify-items-end"),
  centerLeft("grid items-center justify-items-start"),
  center("grid items-center justify-items-center"),
  centerRight("grid items-center justify-items-end"),
  bottomLeft("grid items-end justify-items-start"),
  bottomCenter("grid items-end justify-items-center"),
  bottomRight("grid items-end justify-items-end"),
  ;

  const Align(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}
 */

enum Alignment {
  start("grid grid-col justify-items-start"),
  end("grid grid-col justify-items-end"),
  center("grid grid-col justify-items-center"),
  spaceBetween("grid grid-col justify-items-between"),
  spaceAround("grid grid-col justify-items-around"),
  spaceEvenly("grid grid-col justify-items-evenly"),
  stretch("grid grid-col justify-items-stretch"),
  ;

  const Alignment(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}

enum MainRowAlignment {
  start("justify-start"),
  end("justify-end"),
  center("justify-center"),
  spaceBetween("justify-between"),
  spaceAround("justify-around"),
  spaceEvenly("justify-evenly"),
  stretch("justify-stretch"),
  ;

  const MainRowAlignment(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}

enum CrossRowAlignment {
  start("items-start"),
  end("items-end"),
  center("items-center"),
  stretch("items-stretch"),
  ;

  const CrossRowAlignment(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}
