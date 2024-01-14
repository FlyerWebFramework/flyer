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
      padding: $(EdgeInsets.only(bottom: 4.rem, top: 2.rem)),
      child: Row.full(
        mainRowAlignment: $(MainRowAlignment.start),
        crossRowAlignment: $(CrossRowAlignment.start),
        children: [
          Column(
            children: [
              Padding(
                padding: $(EdgeInsets.symmetric(vertical: 8.px)),
                child: Svg.asset('logo.svg', size: Size(9.rem, 4.rem)),
              ),
              Text($("Copyright © 2020 Nexcent ltd.")),
              Text.newLine(),
              Text($("All rights reserved")),
              SizedBox(height: $(2.rem)),
              Row(
                spacing: $(0.75.rem),
                children: [
                  IconButton(
                    asset: Asset('icons/instagram.svg'),
                    shape: ButtonShape.circle,
                    width: $(1.75.rem),
                    height: $(1.75.rem),
                  ),
                  IconButton(
                    asset: Asset('icons/dribble.svg'),
                    shape: ButtonShape.circle,
                    width: $(1.75.rem),
                    height: $(1.75.rem),
                  ),
                  IconButton(
                    asset: Asset('icons/twitter.svg'),
                    shape: ButtonShape.circle,
                    width: $(1.75.rem),
                    height: $(1.75.rem),
                  ),
                  IconButton(
                    asset: Asset('icons/youtube.svg'),
                    shape: ButtonShape.circle,
                    width: $(1.75.rem),
                    height: $(1.75.rem),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
