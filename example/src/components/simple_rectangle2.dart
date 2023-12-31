import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({required this.size});

  final double size;

  @override
  Widget build() {
    return Container(
      color: $(Color.green),
      width: args.get('size'),
      height: args.get('size'),
      child: SizedBox(),
    );
  }
}
