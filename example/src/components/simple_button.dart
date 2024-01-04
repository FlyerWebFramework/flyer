import 'package:flyer/widgets.dart';

enum N { count, handleClick }

class Size extends ArgsObject {
  Size(this.width, this.height);

  final Unit width;
  final Unit height;

  @override
  List get args => [width, height];

  @override
  Map<String, dynamic> toArgs() {
    return {'width': width, 'height': height};
  }
}

class SimpleButton extends Component {
  const SimpleButton({required this.size, this.disabled = const Bool(false)});

  final Size size;
  final Bool? disabled;

  @override
  Arguments get args => Arguments({'disabled': disabled}).addObject(size);

  @override
  Map<String, dynamic> get obs => {N.count.name: 0};

  @override
  Scripts get scripts => Scripts({
        N.handleClick.name: """() {
          count += 1;
        }""",
      });

  @override
  Widget build() {
    return Button(
      $("Clicked {${N.count.name}}x"),
      disabled: $argByName('disabled'),
      width: $arg(size.width),
      height: $arg(size.height),
      type: $(ButtonType.secondary),
      onTap: $(scripts.get(N.handleClick.name)),
      textStyle: TextStyle(
        fontSize: $(22.pt),
        color: $(Color.blue.shade800),
        fontWeight: $(FontWeight.bold),
        decoration: $(TextDecoration.underline),
        lineHeight: $(2.3.px),
      ),
      decoration: BoxDecoration(color: $(Color.red)),
      styles: [
        ButtonStyle(
          state: ButtonState.hover,
          decoration: BoxDecoration(color: $(Color.red.shade800)),
          textStyle: TextStyle(color: $(Color.blue)),
        ),
        ButtonStyle(
          state: ButtonState.disabled,
          textStyle: TextStyle(color: $(Color.white)),
        ),
      ],
    );
  }
}
