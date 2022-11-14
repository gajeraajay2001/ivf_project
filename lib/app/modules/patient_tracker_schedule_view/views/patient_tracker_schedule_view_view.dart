import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../constants/api_constant.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/patient_tracker_schedule_view_controller.dart';

class PatientTrackerScheduleViewView
    extends GetWidget<PatientTrackerScheduleViewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientTrackerScheduleViewController>(
        init: PatientTrackerScheduleViewController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: appTheme.backgroundTheme,
            body: Obx(() {
              return (controller.hasData.isFalse)
                  ? Center(
                      child: CircularProgressIndicator(
                          color: appTheme.primaryTheme))
                  : Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: ScrollablePositionedList.builder(
                                itemScrollController:
                                    controller.itemScrollController,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    controller.procedureDetailsList.length,
                                itemBuilder: (context, index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    if (controller.isTodayViewed.isFalse) {
                                      controller.procedureDetailsList
                                          .forEach((element) {
                                        if (element.isToday!) {
                                          controller.itemScrollController
                                              .scrollTo(
                                                  index: controller
                                                      .procedureDetailsList
                                                      .indexOf(element),
                                                  duration: Duration(
                                                      milliseconds: 200));
                                        }
                                      });
                                      controller.isTodayViewed.value = true;
                                    }
                                  });

                                  return InkWell(
                                    onTap: () {
                                      showDayDialog(
                                          context: context,
                                          index: index,
                                          controller: controller);
                                    },
                                    child: Container(
                                      width: MySize.getWidth(327),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MySize.getWidth(15),
                                          vertical: MySize.getHeight(10)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: MySize.getHeight(16),
                                          horizontal: MySize.getWidth(15)),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MySize.getHeight(10)),
                                        color: (controller
                                                .procedureDetailsList[index]
                                                .isToday!)
                                            ? appTheme.primaryTheme
                                                .withOpacity(0.2)
                                            : (controller
                                                    .procedureDetailsList[index]
                                                    .isPastDate!)
                                                ? Color(0xffF9EAF3)
                                                : Color(0xffFAFAFA),
                                        boxShadow: appTheme.getShadow,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (!isNullEmptyOrFalse(controller
                                              .procedureDetailsList[index]
                                              .events))
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    controller
                                                        .procedureDetailsList[
                                                            index]
                                                        .events!
                                                        .length, (index2) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: (controller
                                                                    .procedureDetailsList[
                                                                        index]
                                                                    .events!
                                                                    .length !=
                                                                1)
                                                            ? MySize.getHeight(
                                                                7)
                                                            : 0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              MySize.getHeight(
                                                                  25),
                                                          width:
                                                              MySize.getWidth(
                                                                  25),
                                                          child: SvgPicture.asset(
                                                              getImageById(
                                                                  id: controller
                                                                      .procedureDetailsList[
                                                                          index]
                                                                      .events![
                                                                          index2]
                                                                      .eventDbId!)),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                MySize.getWidth(
                                                                    13)),
                                                        Text(
                                                          controller
                                                              .procedureDetailsList[
                                                                  index]
                                                              .events![index2]
                                                              .eventName!,
                                                          style: TextStyle(
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      13),
                                                              color: Color(
                                                                  0xff5B5B5B)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                })),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "Day",
                                                style: TextStyle(
                                                    color: Color(0xffA76488)),
                                              ),
                                              Text(
                                                controller
                                                    .procedureDetailsList[index]
                                                    .day
                                                    .toString()
                                                    .padLeft(2, '0'),
                                                style: TextStyle(
                                                    color: Color(0xffA76488)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
            }),
          );
        });
  }

  showDayDialog(
      {required BuildContext context,
      required int index,
      required PatientTrackerScheduleViewController controller}) {
    bool isForEggReterival = false;
    if (!isNullEmptyOrFalse(controller.procedureDetailsList[index].events)) {
      controller.procedureDetailsList[index].events!.forEach((element) {
        if (element.eventDbId == "624420e970c14f56956f3d1d") {
          isForEggReterival = true;
        }
      });
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  // height: MySize.getHeight(559),
                  width: MySize.getWidth(359),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: MySize.getHeight(45)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: (index >= 1)
                                ? GestureDetector(
                                    onTap: () {
                                      index--;
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: MySize.getWidth(20)),
                                      child: SvgPicture.asset(
                                        "assets/left_arrow.svg",
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                          Expanded(
                            child: Column(children: [
                              Text(
                                  "DAY ${controller.procedureDetailsList[index].day}"),
                              if (!isNullEmptyOrFalse(
                                  controller.procedureDetailsList[index].date))
                                Text(
                                  DateFormat("dd MMM").format(
                                      DateFormat("dd MMMM yyyy").parse(
                                          controller.procedureDetailsList[index]
                                              .date!)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: MySize.getHeight(22)),
                                ),
                              if (!isNullEmptyOrFalse(
                                  controller.procedureDetailsList[index].date))
                                if (DateTime.now() ==
                                    DateFormat("dd MMMM yyyy").parse(controller
                                        .procedureDetailsList[index].date!))
                                  Text(
                                    "TODAY",
                                    style: TextStyle(
                                        fontSize: MySize.getHeight(14),
                                        color: Color(0xffFD7E5C)),
                                  ),
                            ]),
                          ),
                          Expanded(
                            child: (index <
                                    (controller.procedureDetailsList.length -
                                        1))
                                ? GestureDetector(
                                    onTap: () {
                                      index++;
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: MySize.getWidth(20)),
                                      child: SvgPicture.asset(
                                        "assets/right_arrow.svg",
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                      SizedBox(height: MySize.getHeight(20)),
                      Divider(),
                      Column(
                          children: List.generate(
                              controller.procedureDetailsList[index].events!
                                  .length, (ind) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MySize.getHeight(20),
                                  width: MySize.getWidth(20),
                                  child: SvgPicture.asset(getImageById(
                                      id: controller.procedureDetailsList[index]
                                          .events![ind].eventDbId!)),
                                ),
                                SizedBox(width: MySize.getWidth(20)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.procedureDetailsList[index]
                                          .events![ind].eventName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (!isNullEmptyOrFalse(controller
                                        .procedureDetailsList[index]
                                        .events![ind]
                                        .additionalInstruction))
                                      Text(controller
                                          .procedureDetailsList[index]
                                          .events![ind]
                                          .additionalInstruction
                                          .toString()),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        );
                      })),
                      SizedBox(height: MySize.getHeight(10)),
                      // Center(
                      //   child: InkWell(
                      //     onTap: () {
                      //       Get.toNamed(
                      //           Routes.PATIENT_TRACKER_ADD_PRESCRIPTION);
                      //     },
                      //     child: getNeumorphicButton(
                      //         height: 32,
                      //         width: 155,
                      //         text: "+ New Prescription",
                      //         textColor: Color(0xff2CAE51),
                      //         backColor: Color(0xff2CAE51)),
                      //   ),
                      // ),
                      SizedBox(height: MySize.getHeight(40)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isForEggReterival)
                              InkWell(
                                onTap: (isForEggReterival)
                                    ? () {
                                        Get.toNamed(Routes.EDIT_EVENT,
                                            arguments: {
                                              ArgumentConstant
                                                  .isForAddedPatient: true,
                                              ArgumentConstant
                                                  .isForPatientTracker: true,
                                              ArgumentConstant
                                                      .addedPatientProcedureDbId:
                                                  controller
                                                      .patientProcedureDbId,
                                              ArgumentConstant
                                                      .patientReschedulePreviousDate:
                                                  controller
                                                      .procedureDetailsList[
                                                          index]
                                                      .date,
                                            });
                                      }
                                    : null,
                                child: getNeumorphicButton(
                                    height: 32,
                                    width: 132,
                                    text: "Re-Schedule",
                                    textColor: (isForEggReterival)
                                        ? appTheme.primaryTheme
                                        : Colors.black26,
                                    backColor: (isForEggReterival)
                                        ? appTheme.primaryTheme
                                            .withOpacity(0.05)
                                        : appTheme.primaryTheme
                                            .withOpacity(0.03)),
                              ),
                            if (isForEggReterival)
                              SizedBox(width: MySize.getWidth(30)),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: getNeumorphicButton(
                                  height: 32,
                                  width: 65,
                                  text: "Done",
                                  textColor: Color(0xff2CAE51),
                                  backColor:
                                      Color(0xff2CAE51).withOpacity(0.03)),
                            ),
                          ]),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
