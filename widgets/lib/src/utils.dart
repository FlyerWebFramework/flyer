import 'dart:math';

class Utils {
  static String getRandomString(int length) {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var random = Random.secure();
    return List<String>.generate(length, (i) => chars[random.nextInt(chars.length)]).join();
  }
}
