import 'dart:io';

import 'package:flyer/transpiler.dart';
import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final filePath = path.join(DartScript.self.pathToProjectRoot, arguments.first);

  final fileLines = await File(filePath).readAsLines();

  List<TransformedCode> transformedCode = Transformer(fileLines).transform();
  transformedCode.forEach(print);
}


