import 'package:flyer/transpiler/models/parsed_script.dart';
import 'package:flyer/transpiler/parsers/script_parser.dart';
import 'package:test/test.dart';

import 'test_codes.dart';

void main() {
  test('Simple script', () {
    final result = ScriptParser().parse(TestCodes.simpleBlockFunc);
    expect(result.name, "myFunc");
    expect(result.arguments, []);
    expect(result.type, ScriptType.multiLine);
    expect(result.body, "{\n        print('Hello World!!');\n     }");
  });

  test('Simple script with arguments', () {
    final result = ScriptParser().parse(TestCodes.simpleBlockFuncWithArgsOnMoreLines);
    expect(result.name, "myFunc2");
    expect(result.arguments, ['name', 'age', 'object']);
    expect(result.type, ScriptType.multiLine);
    expect(result.body, "{\n        print('Hello World!!');\n     }");
  });

  test('Simple script with arguments on more lines', () {
    final result = ScriptParser().parse(TestCodes.simpleBlockFuncWithArgsOnMoreLines);
    expect(result.name, "myFunc2");
    expect(result.arguments, ['name', 'age', 'object']);
    expect(result.type, ScriptType.multiLine);
    expect(result.body, "{\n        print('Hello World!!');\n     }");
  });

  test('Simple lambda', () {
    final result = ScriptParser().parse(TestCodes.simpleLambdaFunc);
    expect(result.name, "myFunc");
    expect(result.arguments, []);
    expect(result.type, ScriptType.oneLine);
    expect(result.body, r"print('Hello World!!')");
  });

  test('Simple lambda with arguments', () {
    final result = ScriptParser().parse(TestCodes.simpleLambdaFuncWithArgs);
    expect(result.name, "myFunc");
    expect(result.arguments, ['name', 'surname']);
    expect(result.type, ScriptType.oneLine);
    expect(result.body, r"print('Hello $name $surname!!')");
  });
}
