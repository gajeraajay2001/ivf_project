import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/modules/patient_calendar/views/patient_calendar_view.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../controllers/assign_procedure_screen_controller.dart';

class AssignProcedureScreenView
    extends GetWidget<AssignProcedureScreenController> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      disableBarrierInteraction: true,
      onFinish: () {
        controller.tourViewed.value = true;
        controller.tourViewed.refresh();
      },
      builder: Builder(
        builder: (context) {
          if (box.read(ArgumentConstant.tourStep2Started) &&
              controller.tourViewed.isFalse) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Future.delayed(Duration(milliseconds: 200), () {
                ShowCaseWidget.of(context).startShowCase([
                  controller.mcSymbolShowCaseKey.value,
                  controller.nextMcDateShowCaseKey.value,
                ]);
              }),
            );
          }

          return SafeArea(
            child: Obx(() {
              return Scaffold(
                backgroundColor: appTheme.backgroundTheme,
                body: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(17)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MySize.getHeight(40)),
                            Container(
                                child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      size: MySize.getHeight(30)),
                                ),
                                SizedBox(width: MySize.getWidth(16)),
                                SizedBox(
                                  width: MySize.getWidth(220),
                                  child: Text(
                                    "LMP info of patient",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: MySize.getHeight(18)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    // controller.callPatientProcedureAssignment(
                                    //     context: context);
                                    Get.offAllNamed(Routes.HOME_SCREEN,
                                        arguments: {
                                          ArgumentConstant
                                              .isNavigateToPatientsScreen: true,
                                          ArgumentConstant
                                                  .addedPatientProcedureDbId:
                                              controller
                                                  .addedPatientProcedureDbId
                                                  .value,
                                          ArgumentConstant.addedPatientDbId:
                                              controller.addedPatientDbId.value,
                                          ArgumentConstant.procedureDbId:
                                              controller.procedureDbId,
                                        });
                                  },
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 10,
                                      color: appTheme.backgroundTheme,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(
                                          MySize.getHeight(20),
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MySize.getWidth(16),
                                        vertical: MySize.getHeight(7)),
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          color: Color(0xffBD6A8D),
                                          fontSize: MySize.getHeight(12)),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(height: MySize.getHeight(33)),
                            Center(
                              child: Container(
                                height: MySize.getHeight(48),
                                width: MySize.getWidth(48),
                                decoration: BoxDecoration(
                                  color: Color(0xffA76488),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  (!isNullEmptyOrFalse(
                                          controller.addedPatientName.value))
                                      ? (controller.addedPatientName.value
                                                  .length ==
                                              1)
                                          ? controller.addedPatientName
                                              .toUpperCase()
                                          : (controller.addedPatientName.value
                                                      .length >=
                                                  2)
                                              ? "${controller.addedPatientName.value[0].toUpperCase()}${controller.addedPatientName.value[1].toUpperCase()}"
                                              : "gkg"
                                      : "gsg",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.getHeight(16)),
                                ),
                              ),
                            ),
                            SizedBox(height: MySize.getHeight(12)),
                            Center(
                              child: Text(
                                controller.addedPatientName.value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MySize.getHeight(16),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                controller.assignedProcedureName.value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MySize.getHeight(15),
                                ),
                              ),
                            ),
                            SizedBox(height: MySize.getHeight(33)),
                            Center(
                              child: Container(
                                  width: MySize.getWidth(281),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "LMP",
                                        style: TextStyle(
                                            color: appTheme.primaryTheme),
                                      ),
                                      Text(
                                        "Procedure",
                                        style: TextStyle(
                                            color: appTheme.textColor),
                                      ),
                                      Text(
                                        "Team",
                                        style: TextStyle(
                                            color: appTheme.textColor),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: MySize.getHeight(16)),
                            Center(
                                child: Image(
                              image: AssetImage("assets/track_lmp.png"),
                              width: MySize.getWidth(281),
                            )),
                            SizedBox(height: MySize.getHeight(28)),
                            SizedBox(
                                height: MySize.getHeight(3), child: Divider()),
                            SizedBox(height: MySize.getHeight(35)),
                            Row(
                              children: [
                                SizedBox(width: MySize.getWidth(29)),
                                Showcase(
                                  key: controller.mcSymbolShowCaseKey.value,
                                  description:
                                      "To determine when to start the procedure, input patients LMP",
                                  overlayPadding:
                                      EdgeInsets.all(MySize.getHeight(4)),
                                  child: Container(
                                      height: MySize.getHeight(20),
                                      width: MySize.getWidth(20),
                                      child: SvgPicture.asset(
                                          "assets/cal_icon.svg")),
                                ),
                                SizedBox(width: MySize.getWidth(20)),
                                Text(
                                  "When was Patient’s Last\nMenstrual Cycle Start?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: MySize.getHeight(26)),
                            Center(
                                child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PATIENT_CALENDAR,
                                    arguments: {
                                      ArgumentConstant.asDoctor: true,
                                      ArgumentConstant.selectedDate:
                                          controller.selectedDate.value,
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MySize.getHeight(41),
                                    width: MySize.getWidth(52),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appTheme.backgroundTheme,
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(10)),
                                      boxShadow: appTheme.getShadow,
                                    ),
                                    child: Text(
                                      controller.selectedDateString.value
                                          .split("-")[0],
                                      style: TextStyle(
                                          color: appTheme.primaryTheme,
                                          fontSize: MySize.getHeight(13)),
                                    ),
                                  ),
                                  SizedBox(width: MySize.getWidth(15)),
                                  Container(
                                    height: MySize.getHeight(41),
                                    width: MySize.getWidth(95),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appTheme.backgroundTheme,
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(10)),
                                      boxShadow: appTheme.getShadow,
                                    ),
                                    child: Text(
                                      controller.selectedDateString.value
                                          .split("-")[1],
                                      style: TextStyle(
                                          color: appTheme.primaryTheme,
                                          fontSize: MySize.getHeight(13)),
                                    ),
                                  ),
                                  SizedBox(width: MySize.getWidth(15)),
                                  Container(
                                    height: MySize.getHeight(41),
                                    width: MySize.getWidth(68),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appTheme.backgroundTheme,
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(10)),
                                      boxShadow: appTheme.getShadow,
                                    ),
                                    child: Text(
                                      controller.selectedDateString.value
                                          .split("-")[2],
                                      style: TextStyle(
                                          color: appTheme.primaryTheme,
                                          fontSize: MySize.getHeight(13)),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: MySize.getHeight(45)),
                            Center(
                              child: Container(
                                width: MySize.getWidth(254),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Text(
                                      "Probable Date for Next Menstrual Cycle to start.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )),
                                    SizedBox(height: MySize.getHeight(19)),
                                    Showcase(
                                      key: controller
                                          .nextMcDateShowCaseKey.value,
                                      disposeOnTap: true,
                                      onTargetClick: () {
                                        controller.isMcDateSelected.value =
                                            true;
                                        controller.tourViewed.value = true;
                                      },
                                      onToolTipClick: () {
                                        controller.isMcDateSelected.value =
                                            true;
                                        controller.tourViewed.value = true;
                                      },
                                      description:
                                          "This date would be the start of the procedure",
                                      child: Text(
                                        DateFormat("dd MMMM yyy").format(
                                            controller.selectedDate.value
                                                .add(Duration(days: 28))),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: appTheme.primaryTheme),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (controller.isMcDateSelected.isTrue) {
                              Get.toNamed(Routes.CREATE_PROCEDURE_REVIEW,
                                  arguments: {
                                    ArgumentConstant.addedPatientProcedureDbId:
                                        controller
                                            .addedPatientProcedureDbId.value,
                                    ArgumentConstant.procedureDbId:
                                        controller.procedureDbId,
                                    ArgumentConstant.addedPatientDbId:
                                        controller.addedPatientDbId.value,
                                    ArgumentConstant.isForAddedPatient: true,
                                    ArgumentConstant.msCycleStartDate:
                                        DateFormat("dd MMMM yyy").format(
                                            controller.selectedDate.value
                                                .add(Duration(days: 0))),
                                  });
                            } else {
                              getGetXSnackBar(
                                  title: "Error",
                                  msg:
                                      "Please select Menstrual Cycle date first.");
                            }
                          },
                          child: getContainerButton(
                            title: "Next",
                            marginForBottom: 10,
                            textColor: (controller.isMcDateSelected.value)
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            backColor: (controller.isMcDateSelected.value)
                                ? appTheme.primaryTheme
                                : appTheme.primaryTheme.withOpacity(0.6),
                            width: 328,
                            height: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
