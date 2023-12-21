import 'dart:io';

import 'package:flyer/transpiler/common.dart';
import 'package:flyer/transpiler/scanner.dart';
import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final filePath = path.join(DartScript.self.pathToProjectRoot, arguments.first);
  final savePath = path.join(DartScript.self.pathToProjectRoot, "output", "result.svelte");
  final fileLines = await File(filePath).readAsLines();

  List<TransformedCode> transformedCode = Scanner().parse(fileLines);

  final scriptPart = "<script>\n${transformedCode.map((e) => e.javaScript).join('\n\n')}\n</script>\n\n";

  File(savePath).writeAsString(scriptPart);
  "dart run $filePath".start(progress: Progress(savePath.append));
  "cat $savePath".start();
}


