import 'dart:io';

import 'package:flyer/transpiler/common.dart';
import 'package:flyer/transpiler/scanner.dart';
import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

Future<void> main(List<String> arguments) async {
  final webPath = path.join(DartScript.self.pathToProjectRoot, 'web');
  final logsPath = path.join(DartScript.self.pathToProjectRoot, '.logs');

  switch (arguments.first) {
    case 'create':
      createProjectIfNotExists(webPath: webPath, logsPath: logsPath);
    case 'run':
      createProjectIfNotExists(webPath: webPath, logsPath: logsPath);
      'npm run dev'.start(workingDirectory: webPath);
    case 'build':
      // if (arguments.length <= 1) {
      //   print("File path is missing.\n");
      //   print("You have to run:");
      //   print("flyer build <path-to-file>");
      //   exit(1);
      // }
      createProjectIfNotExists(webPath: webPath, logsPath: logsPath);
      await build(
          // filePath: path.join(DartScript.self.pathToProjectRoot, arguments[1]),
          // outputPath: path.join(DartScript.self.pathToProjectRoot, arguments[2]),
          );
    case 'clean':
      deleteDir(webPath, recursive: true);
    case 'doctor':
      checkCommand('node');
      checkCommand('npm');
      'node -v'.forEach((line) => print("Installed node version: $line"));
      'npm -v'.forEach((line) => print("Installed npm version: $line"));
    case 'help':
      print("You can use this commands:");
      print("build        Transpile Flyer project into SvelteKit and Tailwind");
      print("clean        Delete web directory.");
      print("create       Create web directory.");
      print("doctor       Show versions of your commands.");
      print("help         Show this help.");
      print("run          Run web project.");
  }
  exit(0);
}

void checkCommand(String cmd) {
  if (which('git').notfound) {
    print('git is not installed');
    exit(1);
  }
}

createProjectIfNotExists({required String webPath, required String logsPath}) {
  if (exists(webPath)) return;
  checkCommand('git');
  checkCommand('npm');
  'git clone https://github.com/FlyerWebFramework/svelte-project.git web'.start(
    workingDirectory: DartScript.self.pathToProjectRoot,
    progress: Progress(logsPath.append),
  );
  'npm install'.start(workingDirectory: webPath, progress: Progress(logsPath.append));
}

Future<void> build() async {
  final webRootPath = path.join(DartScript.self.pathToProjectRoot, 'web');
  "dart run -r src/main.dart $webRootPath".start();
  // final fileLines = await File(filePath).readAsLines();
  // List<TransformedCode> transformedCode = Scanner().parse(fileLines);
  // final scriptPart = "\n\n<script>\n${transformedCode.map((e) => e.javaScript).join('\n\n')}\n</script>\n\n";
  // print(scriptPart);
  // outputPath.append(scriptPart);
  appendImports();
  copyTree(
    path.join(DartScript.self.pathToProjectRoot, 'static'),
    path.join(webRootPath, "static"),
    recursive: true,
    overwrite: true,
    includeHidden: true,
  );
}

appendImports() {
  final allPages = find(r"*page.svelte", recursive: true).toList();
  for (var page in allPages) {
    page.append("\n\n<script>\n  import {${allComponents.join(', ')}} from \"\$lib/components/index.js\"\n</script>");
  }
}

List<String> get allComponents {
  final components = path.join(DartScript.self.pathToProjectRoot, "web", "src", "lib", "components", "index.js");
  return File(components).readAsLinesSync().map((line) => line.split('}').first.split(' ').last).toList()..remove('');
}
