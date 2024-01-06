import 'package:flyer/widgets.dart';

class NavigationBar extends Component {
  const NavigationBar({
    super.child,
    this.width,
    this.height,
  });

  final Unit? width;
  final Unit? height;

  @override
  Arguments get args => Arguments({'width': width, 'height': height});

  @override
  Widget build() {
    final buttonStyles = [
      ButtonStyle(
        textStyle: TextStyle(
          color: $(Color.gray.shade800),
          decoration: $(TextDecoration.none),
          fontWeight: $(FontWeight.normal),
          fontSize: $(12.pt),
        ),
      ),
    ];

    return Align(
      alignment: $(Alignment.center),
      child: Container(
        width: $argByName('width'),
        height: $argByName('height'),
        child: Row(
          mainRowAlignment: $(MainRowAlignment.spaceAround),
          crossRowAlignment: $(CrossRowAlignment.center),
          children: [
            Padding(
              padding: $(EdgeInsets.symmetric(vertical: 8.px)),
              child: Svg.asset('logo.svg', size: Size(9.rem, 4.rem)),
            ),
            Row(
              spacing: $(2.rem),
              children: [
                Button.link($('Home'), styles: buttonStyles),
                Button.link($('Service'), styles: buttonStyles),
                Button.link($('Feature'), styles: buttonStyles),
                Button.link($('Testimonial'), styles: buttonStyles),
                Button.link($('FAQ'), styles: buttonStyles),
              ],
            ),
            Row(
              spacing: $(1.rem),
              crossRowAlignment: $(CrossRowAlignment.center),
              children: [
                Button.link($('Login'), styles: [
                  ButtonStyle(
                    textStyle: TextStyle(
                      color: $(Color.hex('#4CAF4F')),
                      decoration: $(TextDecoration.none),
                      fontWeight: $(FontWeight.normal),
                      fontSize: $(11.pt),
                    ),
                  ),
                  ButtonStyle(
                    state: ButtonState.hover,
                    textStyle: TextStyle(
                      color: $(Color.hex('#3f8f41')),
                      decoration: $(TextDecoration.none),
                      fontWeight: $(FontWeight.normal),
                    ),
                  ),
                ]),
                Button(
                  $('Sign up'),
                  width: $(6.rem),
                  height: $(2.5.rem),
                  styles: [
                    ButtonStyle(
                      textStyle: TextStyle(
                        decoration: $(TextDecoration.none),
                        fontWeight: $(FontWeight.normal),
                        fontSize: $(11.pt),
                        color: $(Color.white),
                      ),
                      decoration: BoxDecoration(
                        color: $(Color.hex('#4CAF4F')),
                        border: $(Border.all(width: 0.px)),
                      ),
                    ),
                    ButtonStyle(
                      state: ButtonState.hover,
                      textStyle: TextStyle(
                        decoration: $(TextDecoration.none),
                        fontWeight: $(FontWeight.normal),
                      ),
                      decoration: BoxDecoration(
                        color: $(Color.hex('#3f8f41')),
                        border: $(Border.all(width: 0.px)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
