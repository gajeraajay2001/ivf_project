import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';

import '../controllers/ftue_patient_controller.dart';

class FtuePatientView extends GetWidget<FtuePatientController> {
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
                        image: "assets/ftue_patient_01.svg",
                        text1: "IVF Procedures\nare real",
                        text2:
                            "Doctors can easily plan various Feritlity\nprocedures & share within the Team &\nPatients",
                      ),
                      getPageView(
                        image: "assets/ftue_patient_02.svg",
                        text1: "Our experts are\nwith you",
                        text2:
                            "Monitor status & progress of patients\nundergoing Fertility treatments in a Tap",
                      ),
                      getPageView(
                        image: "assets/ftue_patient_03.svg",
                        text1: "Shower all your\nmother’s love",
                        text2:
                            "Maintain digital records of the patients &\nhep increase the success rate of Fertility\ntreatments",
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
                SizedBox(height: MySize.getHeight(61)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getHeight(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (controller.currentIndex.value != 2.0)
                          ? InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PATIENTS_PROFILE);
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: MySize.size18!),
                              ),
                            )
                          : SizedBox(),
                      InkWell(
                        onTap: () {
                          if (controller.currentIndex.value == 2.0) {
                            Get.toNamed(Routes.PATIENTS_PROFILE);
                          } else {
                            controller.currentIndex.value++;
                            controller.pageController.jumpToPage(
                                controller.currentIndex.value.toInt());
                          }
                        },
                        child: Text(
                          (controller.currentIndex.value == 2.0)
                              ? "Get Started"
                              : "Next",
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
        SizedBox(height: MySize.getHeight(80)),
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
        SizedBox(height: MySize.getHeight(22)),
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
