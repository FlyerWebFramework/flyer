import 'package:annotations/annotations.dart';
import 'package:widgets/widgets.dart';

@Template
class Button extends Widget {
  const Button({
    required this.text,
    this.padding = const EdgeInsets.all(8.0),
    this.textColor = Color.red,
    this.backgroundColor = Color.yellow,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build() {
    return Padding(
      padding: padding,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 2, color: Color.green),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  StringBuffer render() {
    throw UnimplementedError();
  }
}
