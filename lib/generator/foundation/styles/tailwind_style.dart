class TailwindStyle {
  const TailwindStyle({
    this.theme,
    this.breakpoint,
    this.action,
    this.type,
    this.subType,
    this.value,
    this.subValue,
    this.description,
  });

  final String? theme;
  final String? breakpoint;
  final String? action;
  final String? type;
  final String? subType;
  final String? value;
  final String? subValue;
  final String? description;

  StringBuffer writePart({
    required StringBuffer buffer,
    required String? part,
    required String delimiter,
  }) {
    if (part != null) {
      buffer.write(part);
      buffer.write(delimiter);
    }
    return buffer;
  }

  @override
  String toString() {
    final StringBuffer result = StringBuffer();
    writePart(buffer: result, part: theme, delimiter: ':');
    writePart(buffer: result, part: breakpoint, delimiter: ':');
    writePart(buffer: result, part: action, delimiter: ':');
    writePart(buffer: result, part: type, delimiter: '-');
    writePart(buffer: result, part: subType, delimiter: value != null ? '-' : '');
    writePart(buffer: result, part: value, delimiter: subValue != null ? '-' : '');
    writePart(buffer: result, part: subValue, delimiter: '');
    return result.toString();
  }

  TailwindStyle copyWith({
    String? theme,
    String? breakpoint,
    String? action,
    String? type,
    String? subType,
    String? value,
    String? subValue,
    String? description,
  }) {
    return TailwindStyle(
      theme: theme ?? this.theme,
      breakpoint: breakpoint ?? this.breakpoint,
      action: action ?? this.action,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      value: value ?? this.value,
      subValue: subValue ?? this.subValue,
      description: description ?? this.description,
    );
  }
}