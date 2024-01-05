import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';
import 'package:flyer/generator/widgets.dart';

enum ButtonType {
  neutral,
  primary,
  secondary,
  accent,
  ghost,
  link,
  info,
  success,
  warning,
  error,
  ;

  String get cssValue => "btn-$name";

  @override
  toString() => cssValue;
}

enum ButtonState {
  normal,
  active,
  disabled,
  focus,
  hover
  ;

  String get cssValue {
    if (this == ButtonState.normal) return '';
    return "$name:";
  }

  @override
  toString() => cssValue;
}

class ButtonStyle {
  const ButtonStyle({this.state = ButtonState.normal, this.textStyle, this.decoration});

  final ButtonState state;
  final TextStyle? textStyle;
  final Decoration? decoration;

  List<String> get classes {
    final builder = ClassBuilder();
    builder.addClassAll(textStyle?.getClasses(ClassState.values.byName(state.name)));
    builder.addClassAll(decoration?.getClasses(ClassState.values.byName(state.name)));
    return builder.classes;
  }
}

class Button extends Component with Gestures {
  Button(this.text, {
    $<Script?>? onTap,
    this.width,
    this.height,
    this.type = const $(ButtonType.primary),
    this.disabled,
    this.textStyle,
    this.decoration,
    this.styles,
  }) {
    this.onTap = onTap;
  }

  final $<Unit?>? width;
  final $<Unit?>? height;
  final $<String> text;
  final $<Bool?>? disabled;
  final $<ButtonType?>? type;
  final TextStyle? textStyle;
  final Decoration? decoration;
  final List<ButtonStyle>? styles;

  @override
  Arguments get args => Arguments({'disabled': disabled});

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("w-{}", width);
    builder.add("h-{}", height);
    builder.addDaisyClass('btn');
    builder.addDaisyClass('$type');
    builder.addClassAll(textStyle?.getClasses());
    builder.addClassAll(decoration?.getClasses());
    styles?.map((e) => e.classes).forEach(builder.addClassAll);
    return builder.classes;
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: 'button',
      events: events,
      classes: classes,
      custom: {"disabled": "{disabled == true ? 'disabled' : ''}"},
      child: Render.text(context.copy, text.value!),
    );
  }
}
