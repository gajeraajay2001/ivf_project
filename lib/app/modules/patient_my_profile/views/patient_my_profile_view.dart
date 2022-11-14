import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../utilities/color_constant.dart';
import '../../../utilities/text_field.dart';
import '../controllers/patient_my_profile_controller.dart';

class PatientMyProfileView extends GetWidget<PatientMyProfileController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.red50,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),
          backgroundColor: ColorConstant.red50,
          title: Text(
            "My Profile",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Container(
          height: MySize.safeHeight,
          width: MySize.screenWidth,
          color: appTheme.backgroundTheme,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MySize.size8),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getColumn(
                          controller: controller.aadharCardNumberController,
                          hint: "Eg. 98734879",
                          title: "AADHAR Card No."),
                      getColumn(
                          controller: controller.aadharMobileNumberController,
                          hint: "Eg. 98734879",
                          title: "Aadhar - Mobile number"),
                      getColumn(
                          controller: controller.otpController,
                          hint: "Eg. 98734879",
                          title: "OTP"),
                      Text(
                        "Upload Aadhar Photos.",
                        style: TextStyle(fontSize: MySize.getHeight(16)),
                      ),
                      SvgPicture.asset("assets/adhar.svg"),
                      SizedBox(height: MySize.getHeight(120)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: MySize.getWidth(20)),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: MySize.getHeight(18)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  color: appTheme.primaryTheme,
                                  shape: NeumorphicShape.flat,
                                  depth: 20,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(
                                          MySize.getHeight(100)))),
                              child: Container(
                                height: MySize.getHeight(55),
                                width: MySize.getWidth(156),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(MySize.size100!)),
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MySize.size20!),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MySize.size33),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column getColumn(
      {required TextEditingController controller,
      required String hint,
      required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: MySize.getHeight(16)),
        ),
        SizedBox(height: MySize.size8),
        getTextField(textEditingController: controller, hintText: hint),
        SizedBox(height: MySize.size28),
      ],
    );
  }
}
