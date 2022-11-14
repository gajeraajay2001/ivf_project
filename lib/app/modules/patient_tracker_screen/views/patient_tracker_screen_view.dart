import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/modules/patient_tracker_reports_view/views/patient_tracker_reports_view_view.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../main.dart';
import '../../../routes/app_pages.dart';
import '../../create_procedure_customise/views/create_procedure_customise_view.dart';
import '../../patient_tracker_contacts_view/views/patient_tracker_contacts_view_view.dart';
import '../../patient_tracker_profile_view/views/patient_tracker_profile_view_view.dart';
import '../../patient_tracker_schedule_view/views/patient_tracker_schedule_view_view.dart';
import '../controllers/patient_tracker_screen_controller.dart';

class PatientTrackerScreenView
    extends GetWidget<PatientTrackerScreenController> {
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
          if (box.read(ArgumentConstant.tourStep3Started) &&
              controller.tourViewed.isFalse) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Future.delayed(Duration(milliseconds: 300), () {
                ShowCaseWidget.of(context).startShowCase([
                  controller.reportShowCaseKey.value,
                  controller.moreActionsShowCaseKey.value,
                  controller.finalShowCaseKey.value,
                ]);
              }),
            );
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: appTheme.backgroundTheme,
              body: Obx(() {
                return (controller.hasData.isFalse)
                    ? Center(
                        child: CircularProgressIndicator(
                            color: appTheme.primaryTheme),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.red50,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Card(
                              color: Color(0xffFFEAF7),
                              elevation: MySize.getHeight(10),
                              shadowColor: Color(0xffE9C6DA),
                              child: Container(
                                height: MySize.getHeight(220),
                                width: MySize.getWidth(360),
                                child: Column(
                                  children: [
                                    SizedBox(height: MySize.getHeight(28)),
                                    Row(
                                      children: [
                                        SizedBox(width: MySize.getWidth(17)),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(Icons.arrow_back,
                                              size: MySize.getHeight(30)),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: MySize.getHeight(36),
                                          width: MySize.getWidth(36),
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFE0F2)
                                                  .withOpacity(0.9),
                                              boxShadow: appTheme.getShadow2,
                                              shape: BoxShape.circle),
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            "assets/edit_icon.svg",
                                            height: MySize.getHeight(16.33),
                                            width: MySize.getWidth(3.33),
                                          ),
                                        ),
                                        SizedBox(width: MySize.getWidth(24)),
                                        Showcase.withWidget(
                                          key: controller
                                              .moreActionsShowCaseKey.value,
                                          height: MySize.getHeight(40),
                                          width: MySize.getWidth(300),
                                          onTargetClick: () {
                                            ShowCaseWidget.of(context).next();
                                          },
                                          overlayPadding: EdgeInsets.symmetric(
                                              vertical: MySize.getHeight(10),
                                              horizontal: MySize.getWidth(10)),
                                          overlayColor: Colors.transparent,
                                          overlayOpacity: 0.2,
                                          showcaseBackgroundColor: Colors.white,
                                          container: Padding(
                                            padding: EdgeInsets.only(
                                                right: MySize.getWidth(50)),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: MySize.getWidth(50),
                                                  child: CustomPaint(
                                                    painter: Arrow(
                                                      strokeColor: Colors.white,
                                                      strokeWidth: 10,
                                                      paintingStyle:
                                                          PaintingStyle.fill,
                                                      isUpArrow: true,
                                                    ),
                                                    child: SizedBox(
                                                      height:
                                                          MySize.getHeight(9),
                                                      width:
                                                          MySize.getWidth(18),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: MySize.getHeight(
                                                            9)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                MySize.getWidth(
                                                                    20),
                                                            vertical: MySize
                                                                .getHeight(5)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(MySize
                                                                    .getHeight(
                                                                        10))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MySize.getWidth(
                                                                  300),
                                                          child: Text(
                                                              "You can perform more actions like rescheduling an event from “ More actions” here."),
                                                        ),
                                                        Spacing.height(10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: PopupMenuButton(
                                            onSelected: (int) {
                                              if (int == 1) {
                                                Get.toNamed(Routes
                                                    .PATIENT_TRACKER_TERMINATE);
                                              }
                                              if (int == 2) {
                                                showDeletePopUp(
                                                    controller: controller,
                                                    context: context);
                                              }
                                            },
                                            offset:
                                                Offset(0, MySize.getHeight(40)),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  value: 0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Assign"),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Edit"),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Terminate"),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Delete"),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Call"),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                              ];
                                            },
                                            child: Container(
                                              height: MySize.getHeight(36),
                                              width: MySize.getWidth(36),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFFE0F2)
                                                      .withOpacity(0.9),
                                                  boxShadow:
                                                      appTheme.getShadow2,
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                "assets/more_icon.svg",
                                                height: MySize.getHeight(16.33),
                                                width: MySize.getWidth(3.33),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: MySize.getWidth(14)),
                                      ],
                                    ),
                                    SizedBox(height: MySize.getHeight(10)),
                                    Row(
                                      children: [
                                        SizedBox(width: MySize.getWidth(34)),
                                        Image(
                                          image: AssetImage(
                                            "assets/priyanka_pic02.png",
                                          ),
                                          height: MySize.getHeight(62),
                                          width: MySize.getWidth(62),
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: MySize.getWidth(16)),
                                        Showcase.withWidget(
                                          key:
                                              controller.finalShowCaseKey.value,
                                          height: MySize.getHeight(40),
                                          width: MySize.getWidth(260),
                                          onTargetClick: () {},
                                          overlayPadding: EdgeInsets.symmetric(
                                              vertical: MySize.getHeight(10),
                                              horizontal: MySize.getWidth(10)),
                                          overlayColor: Colors.transparent,
                                          overlayOpacity: 0.2,
                                          showcaseBackgroundColor: Colors.white,
                                          container: Padding(
                                            padding: EdgeInsets.only(
                                                right: MySize.getWidth(50)),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: MySize.getWidth(50),
                                                  child: CustomPaint(
                                                    painter: Arrow(
                                                      strokeColor: Colors.white,
                                                      strokeWidth: 10,
                                                      paintingStyle:
                                                          PaintingStyle.fill,
                                                      isUpArrow: true,
                                                    ),
                                                    child: SizedBox(
                                                      height:
                                                          MySize.getHeight(9),
                                                      width:
                                                          MySize.getWidth(18),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: MySize.getHeight(
                                                            9)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                MySize.getWidth(
                                                                    20),
                                                            vertical: MySize
                                                                .getHeight(5)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(MySize
                                                                    .getHeight(
                                                                        10))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MySize.getWidth(
                                                                  260),
                                                          child: Text(
                                                              "Now you know that you have a lot of control and trackability of patients."),
                                                        ),
                                                        Spacing.height(10),
                                                        InkWell(
                                                          onTap: () {
                                                            ShowCaseWidget.of(
                                                                    context)
                                                                .next();
                                                            controller
                                                                .updateTourStepApi(
                                                                    context:
                                                                        context);
                                                          },
                                                          child: Text(
                                                            "GO TO HOME",
                                                            style: TextStyle(
                                                                color: appTheme
                                                                    .primaryTheme),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MySize.getWidth(220),
                                                child: Text(
                                                  controller.patientName,
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize:
                                                        MySize.getHeight(20),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${controller.patientAge} Yrs •  ${controller.patientProcedureName}",
                                                style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(14),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Spacing.height(3),
                                              if (!isNullEmptyOrFalse(controller
                                                  .msCycleStart.value))
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller
                                                          .msCycleStart.value,
                                                      style: TextStyle(
                                                        fontSize:
                                                            MySize.getHeight(
                                                                12),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Spacing.width(10),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .PATIENT_CALENDAR,
                                                            arguments: {
                                                              ArgumentConstant
                                                                      .isFormsCycleStartDateUpdate:
                                                                  true,
                                                              ArgumentConstant
                                                                      .msCycleStartDate:
                                                                  controller
                                                                      .msCycleStart
                                                                      .value,
                                                              ArgumentConstant
                                                                      .asDoctor:
                                                                  true,
                                                            });
                                                      },
                                                      child: SvgPicture.asset(
                                                        "assets/edit_icon.svg",
                                                        height:
                                                            MySize.getHeight(
                                                                16.33),
                                                        width: MySize.getWidth(
                                                            3.33),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (isNullEmptyOrFalse(controller
                                                      .msCycleStart.value) ||
                                                  DateFormat("dd MMMM yyyy")
                                                      .parse(controller
                                                          .msCycleStart.value)
                                                      .isAfter(DateTime.now()))
                                                Text("Yet to start")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MySize.getHeight(20)),
                                    Container(
                                      height: MySize.getHeight(40),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            controller.patientTrackerMenuModel
                                                .length, (index) {
                                          return GestureDetector(
                                              onTap: () {
                                                controller
                                                    .patientTrackerMenuModel
                                                    .forEach((element) {
                                                  element.isActive!.value =
                                                      false;
                                                });
                                                controller
                                                    .patientTrackerMenuModel[
                                                        index]
                                                    .isActive!
                                                    .value = true;
                                                controller.selectedPageIndex
                                                    .value = index;
                                                controller.pageController
                                                    .jumpToPage(index);
                                              },
                                              child: (box.read(ArgumentConstant
                                                          .tourStep3Started) &&
                                                      index == 2)
                                                  ? Showcase.withWidget(
                                                      key: controller
                                                          .reportShowCaseKey
                                                          .value,
                                                      height:
                                                          MySize.getHeight(40),
                                                      width:
                                                          MySize.getWidth(250),
                                                      onTargetClick: () {},
                                                      overlayPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: MySize
                                                                  .getHeight(
                                                                      10),
                                                              horizontal: MySize
                                                                  .getWidth(
                                                                      10)),
                                                      overlayColor:
                                                          Colors.transparent,
                                                      overlayOpacity: 0.2,
                                                      showcaseBackgroundColor:
                                                          Colors.white,
                                                      container: Stack(
                                                        children: [
                                                          Positioned(
                                                            right:
                                                                MySize.getWidth(
                                                                    100),
                                                            child: CustomPaint(
                                                              painter: Arrow(
                                                                strokeColor:
                                                                    Colors
                                                                        .white,
                                                                strokeWidth: 10,
                                                                paintingStyle:
                                                                    PaintingStyle
                                                                        .fill,
                                                                isUpArrow: true,
                                                              ),
                                                              child: SizedBox(
                                                                height: MySize
                                                                    .getHeight(
                                                                        9),
                                                                width: MySize
                                                                    .getWidth(
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            child: Container(
                                                              margin: EdgeInsets.only(
                                                                  top: MySize
                                                                      .getHeight(
                                                                          9)),
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: MySize
                                                                      .getWidth(
                                                                          20),
                                                                  vertical: MySize
                                                                      .getHeight(
                                                                          5)),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              MySize.getHeight(10))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: MySize
                                                                        .getWidth(
                                                                            250),
                                                                    child: Text(
                                                                        "All the patient details can be accessed from here."),
                                                                  ),
                                                                  Spacing
                                                                      .height(
                                                                          10),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      ShowCaseWidget.of(
                                                                              context)
                                                                          .next();
                                                                    },
                                                                    child: Text(
                                                                      "NEXT",
                                                                      style: TextStyle(
                                                                          color:
                                                                              appTheme.primaryTheme),
                                                                    ),
                                                                  ),
                                                                  Spacing
                                                                      .height(
                                                                          5),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: getContainer(
                                                          index: index),
                                                    )
                                                  : getContainer(index: index));
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: MySize.getHeight(0)),
                            Expanded(
                              child: PageView(
                                controller: controller.pageController,
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (int index) {
                                  print("Int Index := $index");
                                },
                                children: [
                                  PatientTrackerProfileViewView(),
                                  PatientTrackerScheduleViewView(),
                                  PatientTrackerReportsViewView(),
                                  PatientTrackerContactsViewView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget getContainer({required int index}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MySize.getWidth(10), vertical: MySize.getHeight(3)),
      margin: EdgeInsets.only(right: MySize.getWidth(13)),
      decoration: BoxDecoration(
          color: (controller.patientTrackerMenuModel[index].isActive!.value)
              ? Color(0xffFFF6FB)
              : Color(0xffFFE9F6),
          borderRadius: BorderRadius.circular(
            MySize.getHeight(13),
          ),
          boxShadow: (controller.patientTrackerMenuModel[index].isActive!.value)
              ? [
                  BoxShadow(
                    color: Color(0xffAEAEC0).withOpacity(0.2),
                    offset: Offset(1.5, 1.5),
                  ),
                  BoxShadow(
                    color: Color(0xffFFFFFF).withOpacity(0.7),
                    offset: Offset(-1, -1),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Color(0xffAEAEC0).withOpacity(0.4),
                    offset: Offset(1.5, 1.5),
                  ),
                  BoxShadow(
                    color: Color(0xffFFFFFF),
                    offset: Offset(-1, -1),
                  ),
                  BoxShadow(
                    color: Color(0xffFFFFFF).withOpacity(0.2),
                    offset: Offset(0, 0),
                  ),
                ]),
      alignment: Alignment.center,
      child: Text(
        controller.patientTrackerMenuModel[index].title!,
        style: TextStyle(
          color: (controller.patientTrackerMenuModel[index].isActive!.value)
              ? appTheme.primaryTheme
              : Colors.black,
        ),
      ),
    );
  }

  showDeletePopUp(
      {required BuildContext context,
      required PatientTrackerScreenController controller}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: appTheme.backgroundTheme,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Are you sure you want to delete this patient?"),
                  Spacing.height(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: getButton(
                          text: "Cancel",
                          height: 40,
                          width: 100,
                          textSize: 14,
                          textColor: Colors.black,
                        ),
                      ),
                      Spacing.width(20),
                      InkWell(
                        onTap: () {
                          Get.back();
                          controller.deletePatient(context: context);
                        },
                        child: getButton(
                          text: "Delete",
                          height: 40,
                          width: 100,
                          textSize: 14,
                          textColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
