import 'package:flyer/widgets.dart';

void main(List<String> arguments) {
  WebPage(body: TestComponent()).run();
}

class TestComponent extends Component {
  TestComponent({
    this.count = 0,
    this.visibility = true,
  });

  int count;

  bool visibility;

  int x = $state(0);

  int y = $state(0);

  final String firstName = $state('');

  final String lastName = $state('');

  String get fullName => $derived('{firstName}, {lastName}');

  int get result => $derived(x + y);

  final testScript = $script(#myFunc, () {
    print('Hello World!!');
  });

  //final testScript = $script(
  //  name: #myFunc,
  //  function: () {
  //    print('Hello World!!');
  //  },
  //);

  final scripts = $scripts({
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
      onTap: testScript,
      //onTap: Script(name: #myFunc, function: () => print('Hello World!!')),
      //onTap: scripts.get(#hello),
      child: Container(
        width: 240,
        height: 70,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          "Hello world! ({count})",
          style: TextStyle(
            fontSize: 22,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            lineHeight: 2.3,
          ),
        ),
      ),
    );
  }
}
