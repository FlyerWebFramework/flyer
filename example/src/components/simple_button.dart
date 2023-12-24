import 'package:flyer/widgets.dart';

enum N { count, handleClick }

class SimpleButton extends Component {
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
      width: 240,
      height: 70,
      color: Colors.red,
      onTap: scripts.get(N.handleClick.name),
      child: Text(
        "Clicked {${N.count.name}}x",
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
