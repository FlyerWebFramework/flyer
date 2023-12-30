import 'package:flyer/widgets.dart';

enum N { count, handleClick }

class Size implements PropObject {
  Size(this.width, this.height);

  final Unit width;
  final Unit height;

  @override
  List get props => [width, height];

  List<Variable> toProps() {
    return [
      Variable.create(name: 'width', value: width),
      Variable.create(name: 'height', value: height),
    ];
  }
}

class SimpleButton extends Component {
  const SimpleButton({required this.size});

  final Size size;

  @override
  Props get props => Props([
        ...size.toProps(),
      ]);

  @override
  Map<String, dynamic> get obs => {N.count.name: 0};

  @override
  Scripts get scripts => Scripts({
        N.handleClick.name: """() {
          count += 1;
        }""",
      });

  @override
  Widget build() {
    return Button(
      width: props.get('width'),
      height: props.get('height'),
      color: Color.red,
      onTap: scripts.get(N.handleClick.name),
      child: Text(
        "Clicked {${N.count.name}}x",
        style: TextStyle(
          fontSize: 22,
          color: Color.blue.shade800,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          lineHeight: 2.3,
        ),
      ),
    );
  }
}
