import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size, this.align});

  final Unit size;
  final Alignment? align;

  @override
  Arguments get args => Arguments({'size': size, 'align': align});

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: $var(Color.green),
      alignment: $arg(align),
      width: $arg(size),
      height: $arg(size),
      child: child,
    );
  }
}
