import 'package:flyer/widgets.dart';

class SimpleArticle extends Component {
  const SimpleArticle({
    super.child,
    required this.header,
    required this.content,
    required this.footer,
  });

  final Fragment header;
  final Fragment content;
  final Fragment footer;

  @override
  Props get props => Props([]);

  @override
  List<Fragment> get fragments => [header, content, footer];

  @override
  Map<String, dynamic> get obs => {};

  @override
  Widget build() {
    return Container(
      color: Colors.green,
      width: Variable(500),
      //height: Variable(500),
      child: Wrap(children: [
        Text("<br>"),
        header,
        Text("<br>"),
        Text("<br>"),
        content,
        Text("<br>"),
        Text("<br>"),
        footer,
        Text("<br>"),
        Text("<br>"),
      ]),
    );
  }
}
