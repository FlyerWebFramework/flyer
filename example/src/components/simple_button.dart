import 'package:flyer/widgets.dart';

@component
class SimpleButton extends Component {
  @observable
  int count = 0;

  @script
  get testScript => Script(
        name: #handleClick,
        function: () {
          count += 1;
        },
      );

  @override
  Widget build() {
    return Button(
      width: 240,
      height: 70,
      color: Colors.red,
      onTap: testScript,
      child: Text(
        "Clicked {count}x",
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
