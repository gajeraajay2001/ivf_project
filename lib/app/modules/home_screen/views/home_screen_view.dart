import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/modules/doctor_setting/views/doctor_setting_view.dart';
import 'package:ivf_project/app/modules/home/views/home_view.dart';
import 'package:ivf_project/app/modules/patients/views/patients_view.dart';
import 'package:ivf_project/app/modules/procudures/views/procudures_view.dart';
import 'package:ivf_project/app/theme/app_style.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import '../../../../main.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: getBottomTab(controller: controller),
          backgroundColor: appTheme.backgroundTheme,
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    String token = box.read(ArgumentConstant.token);
                    print(
                        "Token:= $token\n procedureDbId := ${box.read(ArgumentConstant.procedureDbId)}\n procedureId := ${box.read(ArgumentConstant.procedureId)}");

                    controller.selectIndex.value = index;
                    controller.bottomMenu.forEach((element) {
                      element.isActive!.value = false;
                    });
                    if (controller.selectIndex.value == 1) {
                      controller.patientsController
                          .callProceduresListingApi(context: context);
                      if (!controller.isNavigateToPatientsScreen) {
                        controller.patientsController.addedPatientProcedureDbId
                            .value = "";
                        controller.patientsController.addedPatientDbId.value =
                            "";
                      }
                      controller.patientsController.isShowCaseShowed.value =
                          false;
                    }

                    if (!isNullEmptyOrFalse(
                        box.read(ArgumentConstant.isAddPatientShowed))) {
                      controller.patientsController.isAddPatientShowed.value =
                          box.read(ArgumentConstant.isAddPatientShowed);
                    }

                    controller.bottomMenu[index].isActive!.value = true;
                    controller.pageController!.jumpToPage(index);
                  },
                  children: [
                    HomeView(jumpPage: (val) {
                      if (val == 1) {
                        box.write(ArgumentConstant.tourStep1Completed, false);
                        controller.bottomMenu[2].isActive!.value = true;
                        controller.pageController!.jumpToPage(2);
                      } else if (val == 2) {
                        box.write(ArgumentConstant.tourStep2Completed, false);
                        controller.bottomMenu[1].isActive!.value = true;
                        controller.patientsController.tourViewed.value = false;
                        controller.pageController!.jumpToPage(1);
                      }
                    }),
                    PatientsView(),
                    ProcuduresView(),
                    DoctorSettingView(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

getBottomTab({required HomeScreenController controller}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black,
        blurRadius: MySize.size2!,
        spreadRadius: MySize.size2!,
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white,
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
    ], color: appTheme.shadowColor),
    child: Container(
      decoration: BoxDecoration(
        color: ColorConstant.red50,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.bluegray20066,
            spreadRadius: MySize.getHeight(2),
            blurRadius: MySize.getHeight(2),
            offset: Offset(
              4,
              4,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(controller.bottomMenu.length, (index) {
          return InkWell(
            onTap: () {
              controller.bottomMenu.forEach((element) {
                element.isActive!.value = false;
              });
              controller.bottomMenu[index].isActive!.value = true;
              controller.selectIndex.value =
                  controller.bottomMenu[index].index!;
              controller.pageController!
                  .jumpToPage(controller.selectIndex.value);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: MySize.getHeight(8),
                bottom: MySize.getHeight(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MySize.getWidth(21.25),
                      right: MySize.getWidth(21.25),
                    ),
                    child: Container(
                      height: MySize.getHeight(24),
                      width: MySize.getWidth(24),
                      child: SvgPicture.asset(
                        controller.bottomMenu[index].image!,
                        fit: BoxFit.fill,
                        color: (controller.bottomMenu[index].isActive!.isTrue)
                            ? appTheme.primaryTheme
                            : appTheme.pinkColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.bottomMenu[index].label!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleDMSansregular81.copyWith(
                        color: (controller.bottomMenu[index].isActive!.isTrue)
                            ? appTheme.primaryTheme
                            : appTheme.pinkColor,
                        fontSize: MySize.getHeight(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ),
  );
}

class BottomMenuModel {
  String? image;
  String? label;
  int? index;
  RxBool? isActive;

  BottomMenuModel({this.index, this.image, this.isActive, this.label});
}
