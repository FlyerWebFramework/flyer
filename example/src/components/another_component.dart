import 'package:flyer/flyer.dart';

class AnotherComponent extends Component {
  const AnotherComponent({
    this.color = Color.blue,
    this.text = const Str(""),
  });

  @override
  Arguments get args => Arguments({
        "color": color,
        "text": text,
      });

  final Color color;
  final Str text;

  @override
  Widget build() {
    return Box(
      style: BoxStyle([
        Style.size.width(50.px),
        Style.size.height(50.px),
        Style.background.color(args.get("color")),
      ]),
      child: Text.bold(args.get("text")),
    );
  }
}
