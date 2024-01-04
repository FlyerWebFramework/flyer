import 'package:flyer/widgets.dart';

class SimpleButton extends Component {
  int count = 0;

  get handleClick => Script(() {
        count += 1;
      });

  @override
  Widget build() {
    return Button(
      $("Clicked ${count}x"),
      width: $(240.px),
      height: $(70.px),
      type: $(ButtonType.primary),
      onTap: $(handleClick),
      textStyle: TextStyle(
        fontSize: $(22.pt),
        color: $(Color.blue.shade800),
        fontWeight: $(FontWeight.bold),
        decoration: $(TextDecoration.underline),
        lineHeight: $(2.3.px),
      ),
    );
  }
}
