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
  hover;

  String get cssValue {
    if (this == ButtonState.normal) return '';
    return "$name:";
  }

  ClassState get classState {
    if (this == ButtonState.normal) return ClassState.none;
    return ClassState.values.byName(name);
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
    builder.addClassAll(textStyle?.getClasses(state.classState));
    builder.addClassAll(decoration?.getClasses(state.classState));
    return builder.classes;
  }
}

class Button extends Widget with Gestures {
  Button(
    this.text, {
    this.onTap,
    this.width,
    this.height,
    this.type = const $(ButtonType.primary),
    //this.disabled,
    this.textStyle,
    this.decoration,
    this.styles,
  });

  Button.link(
    this.text, {
    this.onTap,
    this.width,
    this.height,
    //this.disabled,
    this.textStyle,
    this.decoration,
    this.styles,
  }) : type = const $(ButtonType.link);

  final $<String> text;
  final $<Unit?>? width;
  final $<Unit?>? height;
  final $<Script?>? onTap;
  //final $<Bool?>? disabled;
  final $<ButtonType?>? type;
  final TextStyle? textStyle;
  final Decoration? decoration;
  final List<ButtonStyle>? styles;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("w-{}", width);
    builder.add("h-{}", height);
    builder.addDaisyClass('btn');
    builder.addDaisyClass('btn-sm');
    builder.addDaisyClass('$type');
    builder.addClassAll(textStyle?.getClasses());
    builder.addClassAll(decoration?.getClasses());
    styles?.map((e) => e.classes).forEach(builder.addClassAll);
    builder.addClass('underline-offset-[1.5px]');
    return builder.classes;
  }

  @override
  Widget build() {
    return WidgetBuilder(
      builder: (context) => Render.element(
        context,
        tag: 'button',
        oneLine: true,
        events: [Event(type: EventType.click, script: onTap)],
        classes: classes,
        //attributes: {"disabled": "{disabled == true ? 'disabled' : ''}"},
        child: Render.text(context.copy, text.value!),
      ),
    );
  }
}
