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

enum ButtonShape {
  circle,
  square,
  rectangle;

  String get cssValue => this != ButtonShape.rectangle ? "btn-$name" : "";

  @override
  toString() => cssValue;
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
    this.shape = ButtonShape.rectangle,
    this.child,
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
    this.shape = ButtonShape.rectangle,
    this.child,
  }) : type = const $(ButtonType.link);

  final $<String> text;
  final $<Unit?>? width;
  final $<Unit?>? height;
  final $<Action?>? onTap;

  //final $<Bool?>? disabled;
  final $<ButtonType?>? type;
  final TextStyle? textStyle;
  final Decoration? decoration;
  final List<ButtonStyle>? styles;
  final ButtonShape? shape;
  final Widget? child;

  @override
  List<String> get classes {
    final builder = ClassBuilder();
    builder.add("w-{}", width);
    builder.add("h-{}", height);
    builder.addDaisyClass('btn');
    builder.addDaisyClass('btn-xs');
    builder.addDaisyClass('$shape');
    builder.addDaisyClass('$type');
    builder.addClassAll(textStyle?.getClasses());
    builder.addClassAll(decoration?.getClasses());
    styles?.map((e) => e.classes).forEach(builder.addClassAll);
    builder.addClass('underline-offset-[1.5px]');
    return builder.classes;
  }

  @override
  Widget build() {
    final hrefAttribute = {
      if (onTap?.name != null)
        "href": onTap!.toString()
      else if (onTap?.value is Url)
        "href": (onTap!.value as Url).url.toString(),
    };

    return WidgetBuilder(
      builder: (context) => Render.element(
        context,
        tag: hrefAttribute.containsKey('href') ? 'a' : 'button',
        oneLine: true,
        events: events,
        classes: classes,
        attributes: {...hrefAttribute},
        //attributes: {"disabled": "{disabled == true ? 'disabled' : ''}"},
        child: Render.list([
          if (child != null) child!.render(context.copy),
          if (child == null) Render.text(context.copy, text.toString()),
        ]),
      ),
    );
  }
}

class IconButton extends Widget {
  IconButton({
    required this.asset,
    required this.shape,
    this.width,
    this.height,
    this.onTap,
  });

  Asset asset;
  ButtonShape? shape;
  final $<Unit?>? width;
  final $<Unit?>? height;
  final $<Action?>? onTap;

  @override
  Widget build() {
    return Button(
      $(""),
      shape: shape,
      width: width,
      height: height,
      styles: [
        ButtonStyle(
          decoration: Decoration(
            margin: $(EdgeInsets.zero),
            padding: $(EdgeInsets.zero),
            border: $(Border.all(width: 0.rem))
          ),
        )
      ],
      child: Wrap(
        children: [
          Container(
            child: Svg.asset(
              asset.path,
              size: Size(
                width?.value ?? 2.rem,
                height?.value ?? 2.rem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
