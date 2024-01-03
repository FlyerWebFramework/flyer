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

enum Alignment {
  start("justify-items-start"),
  end("justify-items-end"),
  center("justify-items-center"),
  spaceBetween("justify-items-between"),
  spaceAround("justify-items-around"),
  spaceEvenly("justify-items-evenly"),
  stretch("justify-items-stretch"),
  ;

  const Alignment(this.cssValue);

  final String cssValue;

  @override
  toString() => cssValue;
}
