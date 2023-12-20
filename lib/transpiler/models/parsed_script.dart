import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_script.freezed.dart';

enum ScriptType { multiLine, oneLine }

@freezed
class ParsedScript with _$ParsedScript {
  const ParsedScript._();
  const factory ParsedScript({
    required String name,
    required List<String> arguments,
    required List<String> body,
    required ScriptType type,
  }) = _ParsedScript;
}
