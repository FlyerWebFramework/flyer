import 'package:flyer/widgets.dart';

class FooterSection extends Component {
  const FooterSection({
    super.child,
    this.width,
    this.height,
    this.color,
  });

  final Unit? width;
  final Unit? height;
  final Color? color;

  @override
  Arguments get args => Arguments({
        'width': width ?? Unit(value: 'full', unit: UnitType.custom, onlyValue: true),
        'height': height,
        'color': color,
      });

  @override
  Widget build() {
    return Container(
      width: $argByName('width'),
      height: $argByName('height'),
      color: $argByName('color'),
      alignment: $(Alignment.centerLeft),
      child: Row.full(
        mainRowAlignment: $(MainRowAlignment.start),
        crossRowAlignment: $(CrossRowAlignment.start),
        children: [
          Padding(
            padding: $(EdgeInsets.symmetric(vertical: 8.px)),
            child: Svg.asset('logo.svg', size: Size(9.rem, 4.rem)),
          ),
        ],
      ),
    );
  }
}
