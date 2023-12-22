import 'package:flyer/generator/foundation.dart';

class Page extends Widget {
  const Page({
    required this.content,
  });

  final Widget content;

  @override
  Widget build() {
    return content;
  }
}
