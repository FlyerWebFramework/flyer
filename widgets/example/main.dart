import 'package:widgets/widgets.dart';

void main(List<String> arguments) {
  print(TestWidget().render().toString());
}

class TestWidget extends Widget {
  @override
  Widget build() {
    return Container(
      width: 240,
      height: 70,
      color: Color.red,
      alignment: Alignment.center,
      child: Text(
        "Hello world!",
        style: TextStyle(
          fontSize: 22,
          color: Color.blue,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          lineHeight: 2.3,
        ),
      ),
    );
  }

  @override
  StringBuffer render() {
    return StringBuffer(build().render());
  }
}
