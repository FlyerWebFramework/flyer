import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({required this.size});

  final double size;

  @override
  Widget build() {
    return Container(
      color: Colors.green,
      width: props.get('size'),
      height: props.get('size'),
      child: SizedBox(),
    );
  }
}
