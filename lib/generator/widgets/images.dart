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

class Asset {
  Asset(this.path);
  final String path;
}

class Svg extends Widget {
  final String sourcePath;
  final Size size;

  const Svg._init(this.sourcePath, {this.size = Constants.defaultSvgSize});

  factory Svg.asset(String assetPath, {Size size = Constants.defaultSvgSize}) {
    final svgPath = path.join('static', assetPath);
    if (exists(svgPath)) {
      return Svg._init(assetPath, size: size);
    }
    throw "Error: Svg in path `$svgPath` doesn't exists.";
  }

  factory Svg.url(Uri url, {Size size = Constants.defaultSvgSize}) {
    if (url.isAbsolute) {
      return Svg._init(url.toString(), size: size);
    }
    throw "Error: Svg url must be absolute address.";
  }

  @override
  StringBuffer render(RenderContext context) {
    final Map<String, String> size = {
      'width': this.size.width.toString(),
      'height': this.size.height.toString(),
    };
    return Render.element(
      context,
      tag: "svg",
      attributes: size,
      child: Render.element(
        context.copy,
        tag: 'image',
        attributes: {
          'xlink:href': sourcePath,
          ...size,
        },
      ),
    );
  }
}

class Image extends Widget {
  final String sourcePath;
  final Size size;
  final String description;

  const Image._init(
    this.sourcePath, {
    this.size = Constants.defaultImageSize,
    this.description = '',
  });

  factory Image.asset(
    String assetPath, {
    Size size = Constants.defaultImageSize,
    String description = '',
  }) {
    final svgPath = path.join('static', assetPath);
    if (exists(svgPath)) {
      return Image._init(assetPath, size: size, description: description);
    }
    throw "Error: Image in path `$svgPath` doesn't exists.";
  }

  factory Image.url(
    Uri url, {
    Size size = Constants.defaultImageSize,
    String description = '',
  }) {
    if (url.isAbsolute) {
      return Image._init(url.toString(), size: size, description: description);
    }
    throw "Error: Image url must be absolute address.";
  }

  @override
  StringBuffer render(RenderContext context) {
    return Render.element(
      context,
      tag: "img",
      attributes: {
        'src': sourcePath,
        'alt': description,
        'width': size.width.toString(),
        'height': size.height.toString(),
      },
    );
  }
}
