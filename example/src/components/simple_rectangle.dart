import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size, this.color = Color.green, this.alignment});

  final Unit size;
  final Color color;
  final Alignment? alignment;

  @override
  Arguments get args => Arguments({'size': size, 'align': alignment, 'color': color});

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: $argByName('color'),
      width: $arg(size),
      height: $arg(size),
      alignment: $arg(alignment),
      child: child,
    );
  }
}
