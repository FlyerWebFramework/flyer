import 'package:flyer/widgets.dart';

enum FontWeight { normal, bold, italic }
enum TextDecoration { none, underline, overline, lineThrough }

class TextStyle {
  TextStyle({
    this.color,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.decoration,
  });

  final Color? color;
  final int? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;


  List<String> get classes {
    List<String> buffer = [];
    if(color != null) buffer.add("text-${color!.value}-${color!.shade}");
    if(fontSize != null) buffer.add("text-[${fontSize}pt]");
    if(fontWeight != null) buffer.add("font-${fontWeight!.name}");
    if(decoration != null) buffer.add(decoration!.name);
    if(lineHeight != null) buffer.add("leading-[${lineHeight}rem]");
    return buffer;
  }
}
