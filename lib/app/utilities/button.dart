import 'package:flutter/material.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

Container getButton({
  required String text,
  double height = 62,
  double width = 320,
  double textSize = 16,
  Color? textColor,
}) {
  return Container(
    height: MySize.getHeight(height),
    width: MySize.getWidth(width),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: appTheme.backgroundTheme,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Colors.black26,
            blurRadius: MySize.size2!,
            spreadRadius: MySize.size2!,
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            color: Colors.white,
            blurRadius: MySize.size2!,
            spreadRadius: MySize.size2!,
          ),
        ],
        borderRadius: BorderRadius.circular(MySize.getHeight(65))),
    child: Text(
      text,
      style: TextStyle(
          color: textColor ?? appTheme.textGrayColor,
          fontSize: MySize.getHeight(textSize)),
    ),
  );
}

Widget getContainerButton(
    {String title = "",
    double width = 332,
    double height = 56,
    Color? backColor,
    Color? textColor,
    double marginForBottom = 10}) {
  return Container(
    width: MySize.getWidth(width),
    height: MySize.getHeight(height),
    margin: EdgeInsets.only(bottom: MySize.getHeight(marginForBottom)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(MySize.getHeight(15)),
      color:
          (isNullEmptyOrFalse(backColor)) ? appTheme.primaryTheme : backColor,
    ),
    alignment: Alignment.center,
    child: Text(
      title,
      style: TextStyle(
          color: (isNullEmptyOrFalse(textColor)) ? Colors.white : textColor,
          fontSize: MySize.getHeight(18)),
    ),
  );
}
