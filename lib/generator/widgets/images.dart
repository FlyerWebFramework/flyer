import 'package:flyer/generator/core.dart';
import 'package:flyer/generator/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:dcli/dcli.dart';

class Favicon extends Widget {
  final String href;

  const Favicon(this.href);

  factory Favicon.asset(String assetPath) {
    final faviconPath = path.join('static', assetPath);
    if (exists(faviconPath)) {
      return Favicon('%sveltekit.assets%/$assetPath');
    }
    throw "Error: Favicon in path `$faviconPath` doesn't exists.";
  }

  factory Favicon.url(Uri url) {
    if (url.isAbsolute) {
      return Favicon(url.toString());
    }
    throw "Error: Favicon url must be absolute address.";
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.link(context, rel: "icon", href: href);
  }
}
