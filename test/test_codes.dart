class TestCodes {
  static const simpleBlockFunc = """
  final testScript = Script(
    name: #myFunc,
    function: () {
      print('Hello World!!');
    },
  );
  """;

  static const simpleBlockFuncWithArgs = """
  final testScript2 = Script(
    name: #myFunc2,
    function: (String name, int age, Map<String, dynamic> object) {
      print('Hello World!!');
    },
  );
  """;


  static const simpleBlockFuncWithArgsOnMoreLines = """
  final testScript3 = Script(
    name: #myFunc2,
    function: (
        String name,
        int age,
        Map<String, dynamic> object,
        ) {
      print('Hello World!!');
    },
  );
  """;

  static const simpleLambdaFunc = r"""
  final lambdaScript = Script(
    name: #myFunc,
    function: () => print('Hello World!!'),
  );
  """;

  static const simpleLambdaFuncWithArgs = r"""
  final lambdaScript2 = Script(
    name: #myFunc,
    function: (String name, String surname) => print('Hello $name $surname!!'),
  );
  """;

  static const simpleLambdaFuncWithArgsOnMoreLines = """
  final testScript3 = Script(
    name: #myFunc2,
    function: (
        String name,
        int age,
        Map<String, dynamic> object,
        ) => print('Hello World!!'),
  );
  """;
}
