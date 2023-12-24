import 'package:flyer/widgets.dart';

class SimpleButton extends Component {
  int count = 0;

  get handleClick => Script(() {
    count += 1;
  });

  @override
  Widget build() {
    return Button(
      width: 240,
      height: 70,
      color: Colors.red,
      onTap: handleClick,
      child: Text(
        "Clicked ${count}x",
        style: TextStyle(
          fontSize: 22,
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          lineHeight: 2.3,
        ),
      ),
    );
  }
}
