import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/theme/app_style.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';

import '../../../constants/sizeConstant.dart';
import '../controllers/patient_my_reports_controller.dart';

class PatientMyReportsView extends GetView<PatientMyReportsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PatientMyReportsController>(
        init: PatientMyReportsController(),
        builder: (controller) {
          return Container(
            height: MySize.screenHeight,
            width: MySize.screenWidth,
            color: appTheme.backgroundTheme,
            child: ListView(
              shrinkWrap: true,
              children: [
                getAppBar(context: context, controller: controller),
                SizedBox(height: MySize.getHeight(5)),
                Column(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: MySize.getHeight(10)),
                      child: Neumorphic(
                        style: NeumorphicStyle(color: appTheme.backgroundTheme),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: MySize.getHeight(15),
                              horizontal: MySize.getWidth(10)),
                          decoration: BoxDecoration(
                            color: Color(0xffFFF6FB).withOpacity(0.8),
                            borderRadius:
                                BorderRadius.circular(MySize.getHeight(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: MySize.getWidth(20)),
                                  SvgPicture.asset(
                                    "assets/my_icon2.svg",
                                    height: MySize.getHeight(35),
                                    width: MySize.getWidth(35),
                                  ),
                                  SizedBox(width: MySize.getWidth(14)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sonar Scan - I",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MySize.getHeight(15)),
                                      ),
                                      Text(
                                        "112337893_SC.pdf",
                                        style: TextStyle(
                                            color: Color(0xff777777),
                                            fontWeight: FontWeight.bold,
                                            fontSize: MySize.getHeight(12)),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: MySize.getWidth(100),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Uploaded by RamGopal Verma",
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MySize.getWidth(10)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getAppBar(
      {required BuildContext context,
      required PatientMyReportsController controller}) {
    return Container(
      width: double.infinity,
      height: MySize.getHeight(90),
      decoration: BoxDecoration(
        color: ColorConstant.pink50A2,
      ),
      child: Align(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Reports",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.textStyleDMSansmedium16.copyWith(
                              fontSize: MySize.getHeight(16),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Dummy Reports",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.textStyleDMSansmedium16.copyWith(
                              fontSize: MySize.getHeight(11),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MySize.getHeight(36),
                      width: MySize.getWidth(36),
                      decoration: BoxDecoration(
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
                          borderRadius: BorderRadius.circular(2000),
                          color: appTheme.shadowColor),
                      // child:
                    ),
                    SvgPicture.asset(
                      "assets/noti_01.svg",
                      fit: BoxFit.cover,
                      height: MySize.getHeight(55),
                      width: MySize.getWidth(55),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
