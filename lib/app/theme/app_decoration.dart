import 'package:flutter/material.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:ivf_project/app/utilities/math_utils.dart';

class AppDecoration {
  static BoxDecoration get groupStylered50 => BoxDecoration(
        color: ColorConstant.red50,
        border: Border.all(
            color: ColorConstant.black90033, width: MySize.getWidth(0.50)),
      );
  static BoxDecoration get groupStylepink50A2 => BoxDecoration(
        color: ColorConstant.pink50A2,
      );
  static BoxDecoration get groupStylered51 => BoxDecoration(
        color: ColorConstant.red50,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.bluegray20066,
            spreadRadius: MySize.getWidth(2),
            blurRadius: MySize.getWidth(2),
            offset: Offset(
              4,
              4,
            ),
          ),
        ],
      );
}
