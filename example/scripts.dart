import 'package:js/js.dart';

main(){
  allowInterop(doComputation);
  allowInterop(sayHello);
  allowInterop(add5);
  allowInterop(add2);
  allowInterop(add3);
}

@JS('doComputation')
String doComputation(String? computationInput) {
  final String computationOutput = computationInput ?? "output";
  return computationOutput;
}

@JS('sayHello')
void sayHello(String name) {
  print("Hello $name!");
}

@JS('add5')
int add5(int x, int y) {
  return x + y;
}

@JS('add2')
int add2(int x, int y, [int? z]) {
  return x + y + (z ?? 0);
}

@JS('add3')
int add3(int x, int y, {required int z}) {
  return x + y + z;
}
