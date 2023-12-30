import 'package:flyer/widgets.dart';

class SimpleButton extends Component {
  int count = 0;

  get handleClick => Script(() {
        count += 1;
      });

  @override
  Widget build() {
    return Button(
      width: $(240.px),
      height: $(70.px),
      color: $(Color.red),
      onTap: handleClick,
      child: Text(
        $("Clicked ${count}x"),
        style: $(
          TextStyle(
            fontSize: 22,
            color: Color.blue.shade800,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            lineHeight: 2.3,
          ),
        ),
      ),
    );
  }
}
