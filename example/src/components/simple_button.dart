import 'package:flyer/widgets.dart';

enum N { count, handleClick }

class Size extends ArgsObject {
  Size(this.width, this.height);

  final Unit width;
  final Unit height;

  @override
  List get args => [width, height];

  @override
  Map<String, dynamic> toArgs() {
    return {'width': width, 'height': height};
  }
}

class SimpleButton extends Component {
  const SimpleButton({required this.size});

  final Size size;

  @override
  Arguments get args => Arguments().addObject(size);

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
      width: $arg(size.width),
      height: $arg(size.height),
      color: $(Color.red),
      onTap: $(scripts.get(N.handleClick.name)),
      child: Text(
        $("Clicked {${N.count.name}}x"),
        style: TextStyle(
          fontSize: $(22.pt),
          color: $(Color.blue.shade800),
          fontWeight: $(FontWeight.bold),
          decoration: $(TextDecoration.underline),
          lineHeight: $(2.3.px),
        ),
      ),
    );
  }
}
