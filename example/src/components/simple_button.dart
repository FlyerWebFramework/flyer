import 'package:flyer/widgets.dart';

class SimpleButton extends Component {
  const SimpleButton({
    this.color = Color.blue,
    this.textColor = Color.red,
    required this.text,
  });

  @override
  Arguments get args => Arguments({
        "color": color,
        "textColor": textColor,
        "text": text,
      });

  final Color color;
  final Color textColor;
  final Str text;

  @override
  Widget build() {
    return Container(
      width: 200.px,
      height: 50.px,
      color: args.get("color"),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10.px),
      child: Text(
        args.get("text"),
        style: TextStyle(
          color: args.get("textColor"),
          fontSize: 18.pt,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
