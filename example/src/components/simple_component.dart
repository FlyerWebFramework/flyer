import 'package:flyer/flyer.dart';

import 'another_component.dart';

class SimpleComponent extends Component {
  const SimpleComponent({
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
        Style.size.width(200.px),
        Style.size.height(200.px),
        Style.border.all.width(0.5.rem),
        Style.border.all.color(Color.red.shade400),
        Style.border.top.color(Color.green.shade400),
        Style.border.right.color(Color.green.shade400),
        Style.border.bottomRight.radius(4.rem),
        Style.background.color(args.get("color")),
        ...Style.size.set(width: 8.rem, height: 8.rem),
      ]),
      child: VBox(children: [
        AnotherComponent(text: args.get("text"), color: Color.red),
        $if(
          condition: Condition.isNotEmpty(args.get("text")),
          block: [
            Text.write(Str('${args.get("text")}123')),
          ],
        ),
        Text.newLine(),
        Text.writeln(Str('Hello world')),
      ]),
    );
  }
}
