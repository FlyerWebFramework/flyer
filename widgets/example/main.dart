import 'package:widgets/widgets.dart';

void main(List<String> arguments) {
  print(TestWidget().render().toString());
}

class TestWidget extends Widget {
  $state(dynamic value) {}

  var count = 0;

  var test = Script(name: #myFunc, function: () => print('Hello World!!'));

  final scripts = Scripts({
    #hello: () => print('Hello World!!'),
    #sayHello: (String name) => print('Hello $name!!'),
    #add: (int x, int y) => print(x + y),
  });

  increment() {
    count += 1;
  }

  @override
  Widget build() {
    return GestureDetector(
      onTap: Script(name: #myFunc, function: () => print('Hello World!!')),
      //onTap: scripts.get(#hello),
      child: Container(
        width: 240,
        height: 70,
        color: Color.red,
        alignment: Alignment.center,
        child: Text(
          "Hello world! ({count})",
          style: TextStyle(
            fontSize: 22,
            color: Color.blue,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            lineHeight: 2.3,
          ),
        ),
      ),
    );
  }

  @override
  StringBuffer render() {
    return StringBuffer(build().render());
  }
}
