import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/utilities/button.dart';
import '../constants/color_constant.dart';
import '../constants/sizeConstant.dart';

showConfirmationDialog(
    {required BuildContext context,
    required String text,
    required String cancelText,
    required String submitText,
    required Function() cancelCallback,
    required Function() submitCallBack}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appTheme.backgroundTheme,
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
                Spacing.height(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: cancelCallback,
                      child: getButton(
                        text: cancelText,
                        height: 40,
                        width: 100,
                        textSize: 14,
                        textColor: Colors.black,
                      ),
                    ),
                    Spacing.width(20),
                    InkWell(
                      onTap: submitCallBack,
                      child: getButton(
                        text: submitText,
                        height: 40,
                        width: 100,
                        textSize: 14,
                        textColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
