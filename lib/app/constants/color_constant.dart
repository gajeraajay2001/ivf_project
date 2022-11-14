import 'package:flutter/material.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

class BaseTheme {
  Color get primaryTheme => fromHex('#FF1A84');
  Color get textColor => fromHex('#BD6A8D');
  Color get appBarColor => fromHex('#FFE0F2');
  Color get backgroundTheme => fromHex('#FFEDF8');
  Color get secondaryColor => fromHex('#BDB7CF');
  Color get orangeColor => fromHex('#FD7E5C');
  Color get borderColor => fromHex('#E8E8E8');
  Color get iconColor => fromHex('#2E3A59');
  Color get black90033 => fromHex('#99000000');
  Color get pink50A2 => fromHex('#a2ffe0f2');
  Color get shadowColor => fromHex('#FFE0F2');
  Color get pinkColor => fromHex('#964973');
  Color get lightPinkColor => fromHex('#FFF4FB');
  // Color get textGrayColor => fromHex('#696F79');background: #FFE0F2E5;
  Color get textGrayColor => Colors.black.withOpacity(0.5);

  List<BoxShadow> get getShadow {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black26,
        blurRadius: MySize.size2!,
        spreadRadius: MySize.size2!,
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.size2!,
        spreadRadius: MySize.size2!,
      ),
    ];
  }

  List<BoxShadow> get getShadow3 {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black12,
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
    ];
  }

  List<BoxShadow> get getShadow2 {
    return [
      BoxShadow(
          offset: Offset(MySize.getWidth(2.5), MySize.getHeight(2.5)),
          color: Color(0xffAEAEC0).withOpacity(0.4),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
      BoxShadow(
          offset: Offset(MySize.getWidth(-1.67), MySize.getHeight(-1.67)),
          color: Color(0xffFFFFFF),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
    ];
  }
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
