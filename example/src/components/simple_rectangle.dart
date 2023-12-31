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
      color: $(Color.green),
      alignment: args.get('align'),
      width: args.get('size'),
      height: args.get('size'),
      child: child,
    );
  }
}
