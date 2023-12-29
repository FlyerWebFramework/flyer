import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size});

  final double size;

  @override
  Props get props => Props([
        Variable<double>.create(name: 'size', value: size),
      ]);

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
