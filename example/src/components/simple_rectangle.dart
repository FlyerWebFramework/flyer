import 'package:flyer/widgets.dart';

class SimpleRectangle extends Component {
  const SimpleRectangle({super.child, required this.size, required this.align});

  final Unit size;
  final Alignment align;

  @override
  Props get props => Props([$(size, name: 'size'), $(align, name: 'align')]);

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: $(Color.green),
      alignment: props.get('align'),
      width: props.get('size'),
      height: props.get('size'),
      child: child,
    );
  }
}
