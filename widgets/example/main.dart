import 'package:widgets/widgets.dart';

void main(List<String> arguments) {
  WebPage(body: TestComponent(count: 5)).run();
}

class TestComponent extends Component {
  TestComponent({this.count = 0});

  @observable
  int count;

  @observable
  String firstName = '';

  @observable
  String lastName = '';

  @computed
  String get fullName => '{firstName}, {lastName}';

  var testScript = Script(
    name: #myFunc,
    function: () {
      print('Hello World!!');
    },
  );

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
      onTap: testScript,
      //onTap: Script(name: #myFunc, function: () => print('Hello World!!')),
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
}
