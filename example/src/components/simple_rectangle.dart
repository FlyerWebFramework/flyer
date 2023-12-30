import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size});

  final Unit size;

  @override
  Props get props => Props([$(size, name: 'size')]);

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: Color.green,
      width: props.get('size'),
      height: props.get('size'),
      child: child,
    );
  }
}
