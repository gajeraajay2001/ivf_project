import 'package:flutter/material.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:ivf_project/app/utilities/math_utils.dart';

import '../constants/sizeConstant.dart';

class AppStyle {
  static TextStyle textStyleDMSansmedium16 = TextStyle(
    color: ColorConstant.pinkA200,
    fontSize: MySize.getHeight(16),
    fontWeight: FontWeight.w500,
  );

  static TextStyle textStyleDMSansbold24 = TextStyle(
    color: ColorConstant.black900,
    fontSize: MySize.getHeight(24),
    fontWeight: FontWeight.w700,
  );

  static TextStyle textStyleAvenirNextWorldregular141 =
      textStyleAvenirNextWorldregular14.copyWith(
    color: ColorConstant.black90087,
  );

  static TextStyle textStyleDMSansregular81 = textStyleDMSansregular8.copyWith(
    color: ColorConstant.gray600,
  );

  static TextStyle textStyleDMSansregular16 = TextStyle(
    color: ColorConstant.black900,
    fontSize: MySize.getHeight(16),
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyleDMSansregular8 = TextStyle(
    color: ColorConstant.pinkA201,
    fontSize: MySize.getHeight(8),
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyleAvenirNextWorldregular14 = TextStyle(
    color: ColorConstant.black90099,
    fontSize: MySize.getHeight(14),
    fontWeight: FontWeight.w400,
  );
}
