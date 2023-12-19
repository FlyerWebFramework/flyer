import 'package:flyer/widgets.dart';

void main(List<String> arguments) {
  WebPage(body: TestComponent()).run();
}

@component
class TestComponent extends Component {
  TestComponent({
    this.count = 0,
    this.visibility = true,
  });

  int count;

  bool? visibility;

  @observable
  int x = 0;

  @observable
  int y = 0;

  @observable
  final String firstName = '';

  @observable
  final String lastName = '';

  @computed
  String get fullName => '{firstName}, {lastName}';

  @computed
  int get result => x + y;

  @script
  final testScript = Script(
    name: #myFunc,
    function: () {
      print('Hello World!!');
    },
  );

  @script
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
