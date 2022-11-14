import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/modules/patient_home/views/patient_home_view.dart';
import 'package:ivf_project/app/modules/patient_my_reports/views/patient_my_reports_view.dart';
import 'package:ivf_project/app/modules/patient_my_schedule/views/patient_my_schedule_view.dart';
import 'package:ivf_project/app/modules/patient_setting/views/patient_setting_view.dart';
import 'package:ivf_project/app/modules/patients/views/patients_view.dart';

import '../../../../main.dart';
import '../controllers/patient_home_screen_controller.dart';

class PatientHomeScreenView extends GetWidget<PatientHomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: appTheme.backgroundTheme,
          bottomNavigationBar:
              bottomBar(context: context, controller: controller),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int) {
                      print("Token := ${box.read(ArgumentConstant.token)}");
                      controller.pageIndex.value = int;
                    },
                    children: [
                      PatientHomeView(),
                      PatientMyScheduleView(),
                      PatientMyReportsView(),
                      PatientSettingView(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget bottomBar(
      {required BuildContext context,
      required PatientHomeScreenController controller}) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.backgroundTheme,
        boxShadow: [
          BoxShadow(
            color: Color(0xffAEAEC0).withOpacity(0.4),
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: Color(0xffFFFFFF).withOpacity(0.4),
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            color: Color(0xffFFFFFF).withOpacity(0.2),
            offset: Offset(0, 0),
          ),
        ],
      ),
      width: MySize.getWidth(360),
      height: MySize.getHeight(53),
      padding: EdgeInsets.symmetric(
          horizontal: MySize.getWidth(30), vertical: MySize.getHeight(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomWidget(
              controller: controller,
              context: context,
              image: "assets/patient/home_icon.svg",
              title: "Home",
              index: 0),
          bottomWidget(
              controller: controller,
              context: context,
              image: "assets/patient/calendar_icon.svg",
              title: "My Schedule",
              index: 1),
          bottomWidget(
              controller: controller,
              context: context,
              image: "assets/patient/folder_icon.svg",
              title: "My Reports",
              index: 2),
          bottomWidget(
              controller: controller,
              context: context,
              image: "assets/patient/setting_icon.svg",
              title: "Settings",
              index: 3),
        ],
      ),
    );
  }

  Widget bottomWidget(
      {required BuildContext context,
      required PatientHomeScreenController controller,
      required int index,
      required String image,
      required String title}) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.pageIndex.value = index;
          controller.pageController.jumpToPage(controller.pageIndex.value);
        },
        child: Container(
          child: Column(
            children: [
              SvgPicture.asset(
                image,
                height: MySize.getHeight(24),
                width: MySize.getWidth(24),
                color: (controller.pageIndex.value == index)
                    ? appTheme.primaryTheme
                    : appTheme.textColor,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: MySize.getHeight(10),
                  color: (controller.pageIndex.value == index)
                      ? appTheme.primaryTheme
                      : appTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
