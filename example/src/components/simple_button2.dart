import 'package:flyer/widgets.dart';

class SimpleButton extends Component {
  int count = 0;

  get handleClick => Script(() {
    count += 1;
  });

  @override
  Widget build() {
    return Button(
      width: const Variable(240),
      height: const Variable(70),
      color: Color.red,
      onTap: handleClick,
      child: Text(
        "Clicked ${count}x",
        style: TextStyle(
          fontSize: 22,
          color: Color.blue.shade800,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          lineHeight: 2.3,
        ),
      ),
    );
  }
}
