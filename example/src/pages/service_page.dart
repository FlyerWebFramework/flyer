import 'package:flyer/widgets.dart';

import '../components/navigation_bar.dart';

class ServicePage extends WebPage {
  const ServicePage();

  @override
  Widget build() {
    return Row(
      mainRowAlignment: $(MainRowAlignment.center),
      crossRowAlignment: $(CrossRowAlignment.center),
      spacing: $(4.rem),
      children: [
        Padding(
          padding: $(EdgeInsets.symmetric(vertical: 8.px)),
          child: Svg.asset('mobile-login.svg', size: Size(25.rem, 25.rem)),
        ),
        Container(
          width: $(50.per),
          child: Column(
            spacing: $(1.25.rem),
            children: [
              Title(
                $("The unseen of spending three years at Pixelgrade"),
                size: HeadlineSize.h2,
                style: TextStyle(
                  color: $(Color.gray.shade800),
                  fontWeight: $(FontWeight.semibold),
                  fontSize: $(26.pt),
                  lineHeight: $(40.px),
                ),
                decoration: Decoration(
                  width: $(80.per),
                  margin: $(EdgeInsets.zero),
                ),
              ),
              Text(
                $(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet justo ipsum. "
                  "Sed accumsan quam vitae est varius fringilla. Pellentesque placerat vestibulum lorem sed porta. "
                  "Nullam mattis tristique iaculis. Nullam pulvinar sit amet risus pretium auctor. "
                  "Etiam quis massa pulvinar, aliquam quam vitae, tempus sem. Donec elementum pulvinar odio.",
                ),
                style: TextStyle(
                  color: $(Color.gray.shade500),
                  fontFamily: $('"Inter", sans-serif;'),
                  fontWeight: $(FontWeight.normal),
                  fontSize: $(10.pt),
                  lineHeight: $(20.px),
                ),
                decoration: Decoration(
                  width: $(90.per),
                  margin: $(EdgeInsets.only(bottom: 0.5.rem)),
                ),
              ),
              DefaultButton(
                'Learn More',
                width: 8.rem,
                height: 3.rem,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
