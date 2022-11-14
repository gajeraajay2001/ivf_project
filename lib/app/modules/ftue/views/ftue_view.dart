import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';

import '../controllers/ftue_controller.dart';

class FtueView extends GetWidget<FtueController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Container(
            height: MySize.safeHeight,
            width: MySize.screenWidth,
            color: appTheme.backgroundTheme,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.currentIndex.value = index.toDouble();
                    },
                    children: [
                      getPageView(
                        image: "assets/Group@2x.svg",
                        text1: "Plan & Share \nIVF Processes",
                        text2:
                            "Doctors can easily plan various Feritlity\n procedures & share within the Team &\n Patients",
                      ),
                      getPageView(
                        image: "assets/OBJECTS.svg",
                        text1: "ATM - All Time\nMonitoring",
                        text2:
                            "Monitor status & progress of patients\nundergoing Fertility treatments in a Tap",
                      ),
                      getPageView(
                        image: "assets/undraw_Online_cv_re_gn0a.svg",
                        text1: "Digital\nRecordkeeping",
                        text2:
                            "Maintain digital records of the patients &\n hep increase the success rate of Fertility\ntreatments",
                      ),
                    ],
                  ),
                ),
                DotsIndicator(
                  dotsCount: 3,
                  position: controller.currentIndex.value,
                  decorator: DotsDecorator(
                    color: Color(0xffE1C4D5), // Inactive color
                    activeColor: appTheme.primaryTheme,
                  ),
                ),
                SizedBox(height: MySize.getHeight(35)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getHeight(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DOCTOR_PROFILE);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontSize: MySize.size18!),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.currentIndex.value == 2.0) {
                            Get.toNamed(Routes.DOCTOR_PROFILE);
                          } else {
                            controller.currentIndex.value++;
                            controller.pageController.jumpToPage(
                                controller.currentIndex.value.toInt());
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: appTheme.primaryTheme,
                              fontSize: MySize.size18!),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.getHeight(29)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Column getPageView({
    required String image,
    required String text1,
    required String text2,
  }) {
    return Column(
      children: [
        SizedBox(height: MySize.getHeight(96)),
        Container(
          height: MySize.getHeight(270),
          width: MySize.getWidth(280),
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/backGround01.png")),
          ),
          alignment: Alignment.center,
          child: SizedBox(
              height: MySize.getHeight(172.07),
              width: MySize.getWidth(183.64),
              child: SvgPicture.asset(image)),
        ),
        SizedBox(height: MySize.getHeight(69)),
        Text(
          text1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: MySize.getHeight(24), fontWeight: FontWeight.bold),
        ),
        SizedBox(height: MySize.getHeight(28)),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MySize.getHeight(14),
          ),
        ),
        SizedBox(height: MySize.getHeight(20)),
      ],
    );
  }
}
