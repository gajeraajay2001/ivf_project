import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';

import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_style.dart';
import '../../../utilities/color_constant.dart';
import '../../../utilities/utilities.dart';
import '../controllers/patient_setting_controller.dart';

class PatientSettingView extends GetView<PatientSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstant.red50,
          border: Border.all(
            color: ColorConstant.black90033,
            width: MySize.getWidth(0.50),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: MySize.getHeight(90),
              decoration: BoxDecoration(
                color: ColorConstant.pink50A2,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MySize.screenWidth,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MySize.getWidth(8),
                          right: MySize.getWidth(11),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/splash_01_01.png",
                                  height: MySize.getHeight(40),
                                  width: MySize.getWidth(40),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MySize.getWidth(12),
                                    bottom: MySize.getHeight(0),
                                  ),
                                  child: Text(
                                    "Settings",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.textStyleDMSansmedium16
                                        .copyWith(
                                      fontSize: MySize.getHeight(16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacing.height(24),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PATIENT_MY_PROFILE);
                      },
                      child: getSettingCard(
                          title: "My Profile",
                          image: "assets/setting_user.svg"),
                    ),
                    Spacing.height(13),
                    InkWell(
                      onTap: () {},
                      child: getSettingCard(
                          title: "Calendar Sync",
                          image: "assets/setting_calendar.svg"),
                    ),
                    Spacing.height(13),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DOCTOR_SUPPORT_SCREEN);
                      },
                      child: getSettingCard(
                          title: "Support",
                          image: "assets/setting_support.svg"),
                    ),
                    Spacing.height(13),
                    InkWell(
                      onTap: () {
                        showConfirmationDialog(
                          context: context,
                          text: "Are you sure you want to logout?",
                          cancelCallback: () {
                            Get.back();
                          },
                          cancelText: "Cancel",
                          submitCallBack: () {
                            box.write(ArgumentConstant.token, "");
                            box.write(ArgumentConstant.userRole, "");
                            box.write(
                                ArgumentConstant.addedPatientProcedureDbId, "");
                            box.write(ArgumentConstant.userId, "");
                            box.write(ArgumentConstant.addedPatientDbId, "");
                            box.write(ArgumentConstant.procedureDbId, "");
                            box.write(ArgumentConstant.procedureId, "");
                            Get.offAllNamed(Routes.SIGN_IN);
                          },
                          submitText: "Yes",
                        );
                      },
                      child: getSettingCard(
                          title: "Logout", image: "assets/setting_logout.svg"),
                    ),
                    Spacing.height(13),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: MySize.getHeight(312),
                height: MySize.getHeight(34),
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "As a Kanu User, I accept to the ",
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(Routes.PRIVACY_POLICY),
                    ),
                    TextSpan(
                      text: " &\n",
                    ),
                    TextSpan(
                      text: "Terms of Usage",
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(Routes.TERMS_USAGES),
                    ),
                  ]),
                  style: TextStyle(fontSize: MySize.getHeight(13)),
                ),
                // child: Text(
                //   "As a Kanu User, I accept to the Privacy Policy & Terms of Usage",
                //   style: TextStyle(fontSize: MySize.getHeight(13)),
                // ),
              ),
            ),
            Spacing.height(41),
          ],
        ),
      ),
    );
  }
}

Widget topWidget() {
  return Container(
    width: double.infinity,
    height: MySize.getHeight(90),
    decoration: BoxDecoration(
      color: ColorConstant.pink50A2,
    ),
    child: Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MySize.screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                left: MySize.getWidth(8),
                right: MySize.getWidth(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/splash_01_01.png",
                        height: MySize.getHeight(40),
                        width: MySize.getWidth(40),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MySize.getWidth(12),
                          bottom: MySize.getHeight(0),
                        ),
                        child: Text(
                          "Settings",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.textStyleDMSansmedium16.copyWith(
                            fontSize: MySize.getHeight(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget getSettingCard({required String title, required String image}) {
  return Center(
    child: Neumorphic(
      style: NeumorphicStyle(color: Color(0xffFFFAFD).withOpacity(0.8)),
      child: Container(
        height: MySize.getHeight(56),
        width: MySize.getWidth(327),
        decoration: BoxDecoration(),
        padding: EdgeInsets.only(left: MySize.getWidth(20)),
        alignment: Alignment.center,
        child: Row(
          children: [
            SvgPicture.asset(image),
            Spacing.width(15),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ),
  );
}
