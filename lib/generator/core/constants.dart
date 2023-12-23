import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as path;

class Constants {
  static const String indent = "  ";
  static final String outputPath = path.join(DartScript.self.pathToProjectRoot, "web");
}