import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import '../controllers/patients_profile_controller.dart';

class PatientsProfileView extends GetWidget<PatientsProfileController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MySize.safeHeight,
          width: MySize.screenWidth,
          color: appTheme.backgroundTheme,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MySize.getWidth(360),
                  height: MySize.getWidth(178),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        color: Colors.black12,
                        spreadRadius: MySize.getHeight(-5),
                        blurRadius: MySize.getHeight(10),
                      ),
                    ],
                  ),
                  child:
                      SvgPicture.asset("assets/prof_01.svg", fit: BoxFit.cover),
                ),
                SizedBox(height: MySize.size42),
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
                      SizedBox(height: MySize.size24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.offAllNamed(Routes.PATIENT_HOME_SCREEN);
                            },
                            child: Container(
                              child: Text(
                                "I’ll do it Later",
                                style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: MySize.getHeight(18)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAllNamed(Routes.PATIENT_HOME_SCREEN);
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
