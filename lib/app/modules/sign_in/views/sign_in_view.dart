import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetWidget<SignInController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: Container(
            height: MySize.safeHeight,
            width: MySize.screenWidth,
            color: appTheme.backgroundTheme,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to \nKanu!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MySize.getHeight(36),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySize.getHeight(14)),
                  Text("Enter your Mobile number to get Started",
                      style: TextStyle(fontSize: MySize.getHeight(14))),
                  SizedBox(height: MySize.getHeight(14)),
                  Row(
                    children: [
                      Container(
                        height: MySize.getHeight(48),
                        width: MySize.getWidth(55),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(MySize.size10!),
                            bottomLeft: Radius.circular(MySize.size10!),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "+91",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(width: MySize.getWidth(1)),
                      InkWell(
                        child: Container(
                          width: MySize.getWidth(263),
                          height: MySize.getHeight(48),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(MySize.getHeight(10)),
                                  bottomRight:
                                      Radius.circular(MySize.getHeight(10)))),
                          child: getTextField(
                              hintText: "Mobile number",
                              textInputType: TextInputType.number,
                              size: MySize.getHeight(48),
                              textEditingController:
                                  controller.mobileController),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.getHeight(53)),
                  InkWell(
                    onTap: () {
                      if (!isNullEmptyOrFalse(
                              controller.mobileController.text) &&
                          !(controller.mobileController.text.length < 10)) {
                        FocusScope.of(context).unfocus();
                        controller.callLoginApi(context: context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter valid mobile number"),
                            duration: Duration(milliseconds: 600),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: MySize.getHeight(62),
                      width: MySize.getWidth(320),
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
                          borderRadius:
                              BorderRadius.circular(MySize.getHeight(65))),
                      child: Text(
                        "Submit",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
