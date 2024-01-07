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
                NavigationButton('Home', url: Url(Uri.parse("/"))),
                NavigationButton('Service', url: Url(Uri.parse("/service"))),
                NavigationButton('Feature', url: Url(Uri.parse("/feature"))),
                NavigationButton('About', url: Url(Uri.parse("/about"))),
                NavigationButton('FAQ', url: Url(Uri.parse("/faq"))),
              ],
            ),
            Row(
              spacing: $(1.rem),
              crossRowAlignment: $(CrossRowAlignment.center),
              children: [LoginButton(), DefaultButton('Sign up')],
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButton extends Component {
  const NavigationButton(this.text, {this.url, super.child});

  final String text;
  final Url? url;

  @override
  Arguments get args => Arguments({'text': text, 'url': url});

  @override
  Widget build() {
    return Button.link(
      $argByName('text'),
      onTap: $argByName('url'),
      styles: [
        ButtonStyle(
          textStyle: TextStyle(
            color: $(Color.gray.shade800),
            decoration: $(TextDecoration.none),
            fontWeight: $(FontWeight.normal),
            fontSize: $(12.pt),
          ),
        ),
      ],
    );
  }
}

class LoginButton extends Component {
  const LoginButton({super.child});

  @override
  Widget build() {
    return Button.link($('Login'), styles: [
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
    ]);
  }
}

class DefaultButton extends Component {
  const DefaultButton(
    this.text, {
    super.child,
    this.width,
    this.height,
  });

  final String text;
  final Unit? width;
  final Unit? height;

  @override
  Arguments get args => Arguments({'text': text, 'width': width ?? 6.rem, 'height': height ?? 2.5.rem});

  @override
  Widget build() {
    return Button(
      $argByName('text'),
      width: $argByName('width'),
      height: $argByName('height'),
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
    );
  }
}
