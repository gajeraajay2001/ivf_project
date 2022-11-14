import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color black90087 = fromHex('#87000000');

  static Color gray600 = fromHex('#964a73');

  static Color pink50A2 = fromHex('#a2ffe0f2');

  static Color pinkA200 = fromHex('#ff307a');

  static Color black90033 = fromHex('#33000000');

  static Color black90099 = fromHex('#99000000');

  static Color pinkA201 = fromHex('#ff1a85');

  static Color black900 = fromHex('#000000');

  static Color bluegray20066 = fromHex('#66adadbf');

  static Color red50 = fromHex('#ffedf7');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
