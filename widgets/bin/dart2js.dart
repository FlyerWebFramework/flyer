import 'dart:io';

Future<void> main(List<String> arguments) async {
  //var result = await Process.run('dart', ['compile', 'js', '-O2', ...arguments]);
  var result = await Process.run('dart', ['compile', 'js', ...arguments]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  final functions = getFunctions(arguments.first);
  var result2 = Process.run('sed', ['/^(function dartProgram() {\$/d; /^})();\$/d;', arguments.last]);
  var file = File(arguments.last.replaceAll('.js', '-out.js'));

  file.writeAsString((await result2).stdout + (await functions).join('\n'));
}

Future<List<String>> getFunctions(String file) async {
  var result = await Process.run('grep', ['-e', '@JS', '-A1', file]);
  if (result.stdout.toString().isEmpty) return [];

  var functions = result.stdout.toString().split('--\n')
      .map((e) => e.replaceAll('\n', '').split(')')[1].split('('))
      .map(
        (e) => MapEntry(
          e.first.split(' ').last,
          e.last.split(',').map((e) => e.split(' ').last.replaceAll(RegExp(r'[\]}]'), '')).toList(),
        ),
      )
      .toList();

  return functions.map((function) => '''
export function ${function.key}(${function.value.join(', ')}) {
  return A.${function.key}(${function.value.join(', ')})
}
''').toList();
}
