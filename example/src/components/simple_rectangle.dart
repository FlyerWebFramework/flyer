import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size, this.color = Color.green, this.align});

  final Unit size;
  final Color color;
  final Align? align;

  @override
  Arguments get args => Arguments({'size': size, 'align': align, 'color': color});

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: $argByName('color'),
      width: $arg(size),
      height: $arg(size),
      child: child,
    );
  }
}
