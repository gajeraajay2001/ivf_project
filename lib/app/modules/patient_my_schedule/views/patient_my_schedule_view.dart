import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../theme/app_style.dart';
import '../controllers/patient_my_schedule_controller.dart';

class PatientMyScheduleView extends GetWidget<PatientMyScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PatientMyScheduleController>(
          init: PatientMyScheduleController(),
          builder: (controller) {
            return Obx(() {
              return Container(
                height: MySize.screenHeight,
                width: MySize.screenWidth,
                color: appTheme.backgroundTheme,
                child: (controller.hasData.isFalse)
                    ? Center(
                        child: CircularProgressIndicator(
                            color: appTheme.primaryTheme),
                      )
                    : Column(
                        children: [
                          getAppBar(context: context, controller: controller),
                          SizedBox(height: MySize.getHeight(16)),
                          Expanded(
                            child: Container(
                              child:
                                  (isNullEmptyOrFalse(
                                          controller.patientProcedureDetail))
                                      ? Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MySize.getWidth(20)),
                                            child: Text(
                                              "No Procedure assigned to you yet,\nPlease confirm your LMP date to show schedule.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(16)),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ScrollablePositionedList
                                                    .builder(
                                                        itemScrollController:
                                                            controller
                                                                .itemScrollController,
                                                        itemCount: controller
                                                            .patientProcedureDetail
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (timeStamp) {
                                                            if (controller
                                                                .isTodayViewed
                                                                .isFalse) {
                                                              controller
                                                                  .patientProcedureDetail
                                                                  .forEach(
                                                                      (element) {
                                                                if (element
                                                                    .isToday!) {
                                                                  controller.itemScrollController.scrollTo(
                                                                      index: controller
                                                                          .patientProcedureDetail
                                                                          .indexOf(
                                                                              element),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              200));
                                                                }
                                                              });
                                                              controller
                                                                  .isTodayViewed
                                                                  .value = true;
                                                            }
                                                          });
                                                          return InkWell(
                                                            onTap: () {
                                                              showDayDialog(
                                                                  context:
                                                                      context,
                                                                  controller:
                                                                      controller,
                                                                  index: index);
                                                            },
                                                            child: Container(
                                                              width: MySize
                                                                  .getWidth(
                                                                      327),
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MySize
                                                                      .getWidth(
                                                                          15),
                                                                  vertical: MySize
                                                                      .getHeight(
                                                                          10)),
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: MySize
                                                                      .getHeight(
                                                                          16),
                                                                  horizontal: MySize
                                                                      .getWidth(
                                                                          15)),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(MySize
                                                                        .getHeight(
                                                                            10)),
                                                                color: (controller
                                                                        .patientProcedureDetail[
                                                                            index]
                                                                        .isToday!)
                                                                    ? appTheme
                                                                        .primaryTheme
                                                                        .withOpacity(
                                                                            0.2)
                                                                    : (controller
                                                                            .patientProcedureDetail[
                                                                                index]
                                                                            .isPastDate!)
                                                                        ? Color(
                                                                            0xffF9EAF3)
                                                                        : Color(
                                                                            0xffFAFAFA),
                                                                boxShadow: appTheme
                                                                    .getShadow,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (!isNullEmptyOrFalse(controller
                                                                      .patientProcedureDetail[
                                                                          index]
                                                                      .events))
                                                                    Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: List.generate(
                                                                            controller.patientProcedureDetail[index].events!.length,
                                                                            (index2) {
                                                                          return Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: (controller.patientProcedureDetail[index].events!.length != 1) ? MySize.getHeight(7) : 0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  height: MySize.getHeight(25),
                                                                                  width: MySize.getWidth(25),
                                                                                  child: SvgPicture.asset(getImageById(id: controller.patientProcedureDetail[index].events![index2].eventDbId!)),
                                                                                ),
                                                                                SizedBox(width: MySize.getWidth(13)),
                                                                                Text(
                                                                                  controller.patientProcedureDetail[index].events![index2].eventName!,
                                                                                  style: TextStyle(fontSize: MySize.getHeight(13), color: Color(0xff5B5B5B)),
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
                                                                            color:
                                                                                Color(0xffA76488)),
                                                                      ),
                                                                      Text(
                                                                        controller
                                                                            .patientProcedureDetail[
                                                                                index]
                                                                            .day
                                                                            .toString()
                                                                            .padLeft(2,
                                                                                '0'),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xffA76488)),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                              ),
                                              // Column(
                                              //   children: List.generate(
                                              //       controller
                                              //           .patientProcedureDetail
                                              //           .length, (index) {
                                              //     return Padding(
                                              //       padding: EdgeInsets.only(
                                              //           bottom:
                                              //               MySize.getHeight(10)),
                                              //       child: Column(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment
                                              //                 .start,
                                              //         children: [
                                              //           if (index == 0)
                                              //             Padding(
                                              //               padding:
                                              //                   EdgeInsets.only(
                                              //                       bottom: MySize
                                              //                           .getHeight(
                                              //                               5)),
                                              //               child: Text(
                                              //                 "Sun, 28 Oct",
                                              //                 style: TextStyle(),
                                              //               ),
                                              //             ),
                                              //           SizedBox(
                                              //               height:
                                              //                   MySize.getHeight(
                                              //                       5)),
                                              //           InkWell(
                                              //             onTap: () {
                                              //               showDayDialog(
                                              //                   context: context,
                                              //                   controller:
                                              //                       controller,
                                              //                   index: index);
                                              //             },
                                              //             child: Neumorphic(
                                              //               style:
                                              //                   NeumorphicStyle(
                                              //                 color: appTheme
                                              //                     .backgroundTheme,
                                              //                 shadowLightColorEmboss:
                                              //                     Colors.white,
                                              //               ),
                                              //               child: Container(
                                              //                 width:
                                              //                     MySize.getWidth(
                                              //                         327),
                                              //                 decoration:
                                              //                     BoxDecoration(
                                              //                   color: appTheme
                                              //                       .backgroundTheme,
                                              //                   borderRadius: BorderRadius
                                              //                       .circular(MySize
                                              //                           .getHeight(
                                              //                               10)),
                                              //                 ),
                                              //                 padding: EdgeInsets.only(
                                              //                     top: MySize
                                              //                         .getHeight(
                                              //                             15),
                                              //                     bottom: MySize
                                              //                         .getHeight(
                                              //                             10)),
                                              //                 child: Row(
                                              //                   crossAxisAlignment:
                                              //                       CrossAxisAlignment
                                              //                           .start,
                                              //                   mainAxisAlignment:
                                              //                       MainAxisAlignment
                                              //                           .center,
                                              //                   children: [
                                              //                     if (!isNullEmptyOrFalse(
                                              //                         controller
                                              //                             .patientProcedureDetail[
                                              //                                 index]
                                              //                             .events))
                                              //                       Expanded(
                                              //                         child:
                                              //                             Column(
                                              //                           crossAxisAlignment:
                                              //                               CrossAxisAlignment
                                              //                                   .start,
                                              //                           children: List.generate(
                                              //                               controller
                                              //                                   .patientProcedureDetail[
                                              //                                       index]
                                              //                                   .events!
                                              //                                   .length,
                                              //                               (ind) {
                                              //                             return Row(
                                              //                                 children: [
                                              //                                   SizedBox(width: MySize.getWidth(20)),
                                              //                                   SizedBox(
                                              //                                     height: MySize.getHeight(20),
                                              //                                     width: MySize.getWidth(20),
                                              //                                     child: SvgPicture.asset(
                                              //                                       getImageById(id: controller.patientProcedureDetail[index].events![ind].eventDbId!),
                                              //                                       height: MySize.getHeight(20),
                                              //                                       width: MySize.getWidth(20),
                                              //                                     ),
                                              //                                   ),
                                              //                                   SizedBox(width: MySize.getWidth(14)),
                                              //                                   Text(
                                              //                                     controller.patientProcedureDetail[index].events![ind].eventName!,
                                              //                                     style: TextStyle(color: Color(0xff5B5B5B).withOpacity(0.8), fontSize: MySize.getHeight(15)),
                                              //                                   ),
                                              //                                 ]);
                                              //                           }),
                                              //                         ),
                                              //                       )
                                              //                     else
                                              //                       Spacer(),
                                              //                     Column(
                                              //                       children: [
                                              //                         Text(
                                              //                           "Day",
                                              //                           style:
                                              //                               TextStyle(
                                              //                             color: Color(
                                              //                                 0xffA76488),
                                              //                           ),
                                              //                         ),
                                              //                         Text(
                                              //                           controller
                                              //                               .patientProcedureDetail[
                                              //                                   index]
                                              //                               .day
                                              //                               .toString()
                                              //                               .padLeft(
                                              //                                   2,
                                              //                                   '0'),
                                              //                           style:
                                              //                               TextStyle(
                                              //                             fontWeight:
                                              //                                 FontWeight.bold,
                                              //                             fontSize:
                                              //                                 MySize.getHeight(17),
                                              //                             color: Color(
                                              //                                 0xffA76488),
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                     SizedBox(
                                              //                         width: MySize
                                              //                             .getWidth(
                                              //                                 50)),
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     );
                                              //   }),
                                              // ),
                                            ],
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
              );
            });
          }),
    );
  }

  showDayDialog(
      {required BuildContext context,
      required int index,
      required PatientMyScheduleController controller}) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
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
                                "DAY ${controller.patientProcedureDetail[index].day}"),
                            if (!isNullEmptyOrFalse(
                                controller.patientProcedureDetail[index].date))
                              Text(
                                "${DateFormat("dd MMM").format(DateFormat("dd MMMM yyyy").parse(controller.patientProcedureDetail[index].date!))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: MySize.getHeight(22)),
                              ),
                            if (!isNullEmptyOrFalse(
                                controller.patientProcedureDetail[index].date))
                              if (DateTime.now() ==
                                  DateFormat("dd MMMM yyyy").parse(controller
                                      .patientProcedureDetail[index].date!))
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
                                  (controller.patientProcedureDetail.length -
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
                            controller.patientProcedureDetail[index].events!
                                .length, (ind) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: MySize.getHeight(20),
                                width: MySize.getWidth(20),
                                child: SvgPicture.asset(getImageById(
                                    id: controller.patientProcedureDetail[index]
                                        .events![ind].eventDbId!)),
                              ),
                              SizedBox(width: MySize.getWidth(20)),
                              Column(
                                children: [
                                  Text(
                                    controller.patientProcedureDetail[index]
                                        .events![ind].eventName!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(controller.patientProcedureDetail[index]
                                      .events![ind].additionalInstruction!),
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
                    //       // Get.toNamed(Routes.PATIENT_TRACKER_ADD_PRESCRIPTION);
                    //     },
                    //     child: getNeumorphicButton(
                    //         height: 32,
                    //         width: 155,
                    //         text: "+ New Prescription",
                    //         textColor: Color(0xff2CAE51),
                    //         backColor: Color(0xff2CAE51)),
                    //   ),
                    // ),
                    // SizedBox(height: MySize.getHeight(40)),
                    // Row(children: [
                    //   getNeumorphicButton(
                    //       height: 32,
                    //       width: 132,
                    //       text: "Re-Schedule",
                    //       textColor: appTheme.primaryTheme,
                    //       backColor: appTheme.primaryTheme),
                    //   SizedBox(width: MySize.getWidth(30)),
                    //   getNeumorphicButton(
                    //       height: 32,
                    //       width: 65,
                    //       text: "Done",
                    //       textColor: Color(0xff2CAE51),
                    //       backColor: Color(0xff2CAE51)),
                    // ]),
                  ],
                ),
              ),
            );
          });
        });
  }

  getAppBar(
      {required BuildContext context,
      required PatientMyScheduleController controller}) {
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
                      child: Text(
                        "My Schedule",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.textStyleDMSansmedium16.copyWith(
                          fontSize: MySize.getHeight(16),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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

// ==> Different Ui for procedure cards.
/*Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: List.generate(
                                              controller.patientProcedureDetail
                                                  .length, (index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MySize.getHeight(10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (index == 0)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MySize.getHeight(
                                                                  5)),
                                                      child: Text(
                                                        "Sun, 28 Oct",
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                      height:
                                                          MySize.getHeight(5)),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(height: MySize.getHeight(10)),
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                              color: Color(0xff535353),
                                              fontSize: MySize.getHeight(16),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Wed, 05 Nov",
                                          style: TextStyle(
                                              color: Color(0xff535353),
                                              fontSize: MySize.getHeight(14),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: MySize.getHeight(10)),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                              color: appTheme.backgroundTheme),
                                          child: Container(
                                            height: MySize.getHeight(159),
                                            width: MySize.getWidth(327),
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFF6FB),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.getHeight(10)),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: MySize.getHeight(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: MySize.getWidth(
                                                            20)),
                                                    SvgPicture.asset(
                                                      "assets/capsul.svg",
                                                      height:
                                                          MySize.getHeight(20),
                                                      width:
                                                          MySize.getWidth(20),
                                                    ),
                                                    SizedBox(
                                                        width: MySize.getWidth(
                                                            14)),
                                                    Text(
                                                      "Medication",
                                                      style: TextStyle(
                                                          color: Color(
                                                                  0xff5B5B5B)
                                                              .withOpacity(0.8),
                                                          fontSize:
                                                              MySize.getHeight(
                                                                  15)),
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Day",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffA76488),
                                                          ),
                                                        ),
                                                        Text(
                                                          "06",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MySize
                                                                .getHeight(17),
                                                            color: Color(
                                                                0xffA76488),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        width: MySize.getWidth(
                                                            50)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MySize.getWidth(
                                                            20)),
                                                    SvgPicture.asset(
                                                      "assets/injection.svg",
                                                      height:
                                                          MySize.getHeight(20),
                                                      width:
                                                          MySize.getWidth(20),
                                                    ),
                                                    SizedBox(
                                                        width: MySize.getWidth(
                                                            14)),
                                                    Text(
                                                      "Medication",
                                                      style: TextStyle(
                                                          color: Color(
                                                                  0xff5B5B5B)
                                                              .withOpacity(0.8),
                                                          fontSize:
                                                              MySize.getHeight(
                                                                  15)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: MySize.getHeight(10)),
                                        Column(
                                          children: List.generate(5, (index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MySize.getHeight(10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (index == 0)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MySize.getHeight(
                                                                  5)),
                                                      child: Text(
                                                        "Sun, 28 Oct",
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                      height:
                                                          MySize.getHeight(5)),
                                                  Neumorphic(
                                                    style: NeumorphicStyle(
                                                      color: appTheme
                                                          .backgroundTheme,
                                                      shadowLightColorEmboss:
                                                          Colors.white,
                                                    ),
                                                    child: Container(
                                                      height:
                                                          MySize.getHeight(65),
                                                      width:
                                                          MySize.getWidth(327),
                                                      decoration: BoxDecoration(
                                                        color: appTheme
                                                            .backgroundTheme,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(MySize
                                                                    .getHeight(
                                                                        10)),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                  width: MySize
                                                                      .getWidth(
                                                                          20)),
                                                              SvgPicture.asset(
                                                                "assets/capsul.svg",
                                                                height: MySize
                                                                    .getHeight(
                                                                        20),
                                                                width: MySize
                                                                    .getWidth(
                                                                        20),
                                                              ),
                                                              SizedBox(
                                                                  width: MySize
                                                                      .getWidth(
                                                                          14)),
                                                              Text(
                                                                "Medication",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                            0xff5B5B5B)
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize: MySize
                                                                        .getHeight(
                                                                            15)),
                                                              ),
                                                              Spacer(),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "Day",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffA76488),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "0${index + 1}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          MySize.getHeight(
                                                                              17),
                                                                      color: Color(
                                                                          0xffA76488),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  width: MySize
                                                                      .getWidth(
                                                                          50)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),*/
