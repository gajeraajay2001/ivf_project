import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/theme/app_style.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  HomeView({this.jumpPage});
  Function(int)? jumpPage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        MySize().init(context);
        return Obx(() {
          return Scaffold(
              body: Container(
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
                                        "Home",
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
                                // InkWell(
                                //   onTap: () {},
                                //   child: Stack(
                                //     alignment: Alignment.center,
                                //     children: [
                                //       Container(
                                //         height: MySize.getHeight(36),
                                //         width: MySize.getWidth(36),
                                //         decoration: BoxDecoration(
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 offset: Offset(2, 2),
                                //                 color: Colors.black26,
                                //                 blurRadius: MySize.size2!,
                                //                 spreadRadius: MySize.size2!,
                                //               ),
                                //               BoxShadow(
                                //                 offset: Offset(-1, -1),
                                //                 color: Colors.white,
                                //                 blurRadius: MySize.size2!,
                                //                 spreadRadius: MySize.size2!,
                                //               ),
                                //             ],
                                //             borderRadius:
                                //                 BorderRadius.circular(2000),
                                //             color: appTheme.shadowColor),
                                //         // child:
                                //       ),
                                //       SvgPicture.asset(
                                //         "assets/noti_01.svg",
                                //         fit: BoxFit.cover,
                                //         height: MySize.getHeight(55),
                                //         width: MySize.getWidth(55),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MySize.getWidth(10),
                              top: MySize.getHeight(15),
                              left: MySize.getWidth(22)),
                          child: Text(
                            "Hi ${(isNullEmptyOrFalse(box.read(ArgumentConstant.doctorName))) ? "Doctor" : box.read(ArgumentConstant.doctorName)}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.textStyleDMSansbold24.copyWith(
                              fontSize: MySize.getHeight(24),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MySize.getWidth(23),
                            right: MySize.getWidth(10),
                          ),
                          child: Text(
                            (controller.hasData.isFalse)
                                ? ""
                                : (isNullEmptyOrFalse(
                                        controller.eggRetrivalDataList))
                                    ? "you have no events yet.."
                                    : "Your upcoming events this week.",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.textStyleAvenirNextWorldregular14
                                .copyWith(
                              fontSize: MySize.getHeight(14),
                            ),
                          ),
                        ),
                        if (controller.profileCheck.isTrue)
                          SizedBox(height: MySize.getHeight(20)),
                        if (controller.profileCheck.isTrue)
                          getCompleteProfilePopUp(
                              context: context, controller: controller),
                        if (controller.allTourStepsJustCompleted.isTrue)
                          Padding(
                            padding: EdgeInsets.only(top: MySize.getHeight(20)),
                            child: getTourCompletedWidget(
                                controller: controller, context: context),
                          ),
                        if (!isNullEmptyOrFalse(controller.tourData))
                          if (!isNullEmptyOrFalse(controller.tourData.steps))
                            if (!controller.tourData.isCompleted!)
                              Padding(
                                padding:
                                    EdgeInsets.only(top: MySize.getHeight(20)),
                                child: tourWidget(
                                    controller: controller, context: context),
                              ),
                        SizedBox(height: MySize.getHeight(20)),
                        Container(
                          margin: EdgeInsets.only(
                              right: MySize.getWidth(10),
                              left: MySize.getWidth(10)),
                          decoration: BoxDecoration(
                              color: ColorConstant.red50,
                              borderRadius:
                                  BorderRadius.circular(MySize.getHeight(10))),
                          padding: EdgeInsets.only(top: MySize.getHeight(20)),
                          child: (controller.hasData.isFalse)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: appTheme.primaryTheme,
                                  ),
                                )
                              : (isNullEmptyOrFalse(
                                      controller.eggRetrivalDataList)
                                  ? Center(
                                      child: Text(""),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          child: GroupedListView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            elements:
                                                controller.eggRetrivalDataList,
                                            groupBy: (EggRetreivalDataModel
                                                element) {
                                              return element.dateTime;
                                            },
                                            groupHeaderBuilder:
                                                (EggRetreivalDataModel
                                                    element) {
                                              return Row(
                                                children: [
                                                  if (DateTime.now().day ==
                                                          element
                                                              .dateTime!.day &&
                                                      DateTime.now().month ==
                                                          element.dateTime!
                                                              .month &&
                                                      DateTime.now().year ==
                                                          element
                                                              .dateTime!.year)
                                                    Text("Today "),
                                                  if (DateTime.now().day ==
                                                          element
                                                              .dateTime!.day &&
                                                      DateTime.now().month ==
                                                          element.dateTime!
                                                              .month &&
                                                      DateTime.now().year ==
                                                          element
                                                              .dateTime!.year)
                                                    Container(
                                                      height:
                                                          MySize.getHeight(5),
                                                      width: MySize.getWidth(5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Colors.black26),
                                                    ),
                                                  if (DateTime.now().day ==
                                                          element
                                                              .dateTime!.day &&
                                                      DateTime.now().month ==
                                                          element.dateTime!
                                                              .month &&
                                                      DateTime.now().year ==
                                                          element
                                                              .dateTime!.year)
                                                    SizedBox(
                                                        width:
                                                            MySize.getWidth(2)),
                                                  Text(DateFormat("dd MMM yyyy")
                                                      .format(
                                                          element.dateTime!)),
                                                ],
                                              );
                                            },
                                            indexedItemBuilder: (context,
                                                EggRetreivalDataModel element,
                                                index) {
                                              return InkWell(
                                                onTap: () {
                                                  box.write(
                                                      ArgumentConstant
                                                          .getUserDbId,
                                                      element.userDbId!);
                                                  Get.toNamed(
                                                      Routes
                                                          .PATIENT_TRACKER_SCREEN,
                                                      arguments: {
                                                        ArgumentConstant
                                                                .patientProcedureDbId:
                                                            element.id,
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: MySize.getHeight(15),
                                                      left:
                                                          MySize.getWidth(20)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: MySize
                                                                .getHeight(25),
                                                            width:
                                                                MySize.getWidth(
                                                                    25),
                                                            child: SvgPicture.asset(
                                                                "assets/image01.svg",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: MySize
                                                                    .getHeight(
                                                                        25),
                                                                width: MySize
                                                                    .getWidth(
                                                                        25)),
                                                          ),
                                                          SizedBox(
                                                              width: MySize
                                                                  .getWidth(
                                                                      22)),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${element.patientName!}",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .getHeight(
                                                                            17),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  height: MySize
                                                                      .getHeight(
                                                                          2)),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Egg Retrieval ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MySize.getHeight(
                                                                                13),
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  Container(
                                                                    height: MySize
                                                                        .getHeight(
                                                                            5),
                                                                    width: MySize
                                                                        .getWidth(
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .black26),
                                                                  ),
                                                                  Text(
                                                                    " ${element.procedureName!}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MySize.getHeight(
                                                                                13),
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: MySize
                                                                      .getHeight(
                                                                          2)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              MySize.getHeight(
                                                                  10)),
                                                      Divider(),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: ListView.separated(
                                        //       itemBuilder: (context, index) {
                                        //         return Container(
                                        //           child: Column(
                                        //             children: [
                                        //               Column(
                                        //                 children: List.generate(
                                        //                     controller
                                        //                         .patientsList
                                        //                         .length,
                                        //                     (index1) => InkWell(
                                        //                           onTap: () {
                                        //                             box.write(
                                        //                                 ArgumentConstant
                                        //                                     .getUserDbId,
                                        //                                 controller
                                        //                                     .patientsList[index1]
                                        //                                     .patient!
                                        //                                     .patient!
                                        //                                     .userDbId!);
                                        //                             Get.toNamed(
                                        //                                 Routes
                                        //                                     .PATIENT_TRACKER_SCREEN,
                                        //                                 arguments: {
                                        //                                   ArgumentConstant.patientProcedureDbId: controller
                                        //                                       .patientsList[index1]
                                        //                                       .patient!
                                        //                                       .id,
                                        //                                 });
                                        //                           },
                                        //                           child:
                                        //                               Container(
                                        //                             padding: EdgeInsets.only(
                                        //                                 left: MySize.getWidth(
                                        //                                     20)),
                                        //                             child:
                                        //                                 Column(
                                        //                               children: [
                                        //                                 Row(
                                        //                                   children: [
                                        //                                     Container(
                                        //                                       height: MySize.getHeight(25),
                                        //                                       width: MySize.getWidth(25),
                                        //                                       child: SvgPicture.asset("assets/image01.svg", fit: BoxFit.cover, height: MySize.getHeight(25), width: MySize.getWidth(25)),
                                        //                                     ),
                                        //                                     SizedBox(width: MySize.getWidth(22)),
                                        //                                     Column(
                                        //                                       crossAxisAlignment: CrossAxisAlignment.start,
                                        //                                       children: [
                                        //                                         Text(
                                        //                                           "${controller.patientsList[index1].patient!.patient!.name}",
                                        //                                           style: TextStyle(fontSize: MySize.getHeight(17), fontWeight: FontWeight.w500),
                                        //                                         ),
                                        //                                         SizedBox(height: MySize.getHeight(2)),
                                        //                                         Text(
                                        //                                           "${controller.patientsList[index1].patient!.procedure!.name}",
                                        //                                           style: TextStyle(fontSize: MySize.getHeight(13), fontWeight: FontWeight.w400),
                                        //                                         ),
                                        //                                         SizedBox(height: MySize.getHeight(2)),
                                        //                                         Text(
                                        //                                           "11 AM  |  Sarayu Clinic",
                                        //                                           style: TextStyle(fontSize: MySize.getHeight(12), fontWeight: FontWeight.w400),
                                        //                                         ),
                                        //                                       ],
                                        //                                     ),
                                        //                                   ],
                                        //                                 ),
                                        //                                 SizedBox(
                                        //                                     height:
                                        //                                         MySize.getHeight(10)),
                                        //                                 Divider(),
                                        //                               ],
                                        //                             ),
                                        //                           ),
                                        //                         )),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         );
                                        //       },
                                        //       separatorBuilder:
                                        //           (context, index) {
                                        //         return SizedBox(
                                        //           height: MySize.getHeight(5),
                                        //         );
                                        //       },
                                        //       itemCount: 1),
                                        // ),
                                      ],
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        });
      },
    );
  }

  Widget getTourCompletedWidget(
      {required BuildContext context, required HomeController controller}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      color: Colors.white,
      child: Container(
        height: MySize.getHeight(135),
        width: MySize.getWidth(314),
        padding: EdgeInsets.symmetric(
            vertical: MySize.getHeight(15), horizontal: MySize.getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Tour Completed',
              style: TextStyle(
                  color: appTheme.primaryTheme,
                  fontSize: MySize.getHeight(24),
                  fontWeight: FontWeight.w700),
            ),
            Spacing.height(5),
            Text(
              "You can look back at this tour again if needed from the Settings Menu",
              style: TextStyle(
                  color: Color(0xff848384), fontSize: MySize.getHeight(13)),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                controller.allTourStepsJustCompleted.value = false;
                box.write(ArgumentConstant.allTourStepsJustCompleted, false);
              },
              child: Text(
                'OKAY GOT IT!',
                style: TextStyle(
                    color: appTheme.primaryTheme,
                    fontSize: MySize.getHeight(15),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tourWidget(
      {required BuildContext context, required HomeController controller}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: MySize.getHeight(20), horizontal: MySize.getWidth(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySize.getHeight(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let us help you get started.",
              style: TextStyle(
                  color: appTheme.primaryTheme,
                  fontWeight: FontWeight.w700,
                  fontSize: MySize.getHeight(22)),
            ),
            Spacing.height(7),
            Text(
              "We will guide you through a step- by step flow as below to set you up",
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: MySize.getHeight(13)),
            ),
            Spacing.height(10),
            Column(
              children:
                  List.generate(controller.tourData.steps!.length, (index) {
                return Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: MySize.getWidth(10)),
                    onTap: (controller.tourData.steps![index].isCompleted!)
                        ? () {
                            controller.resetTourStepData(context: context);
                          }
                        : () {
                            if (index == 0) {
                              box.write(
                                  ArgumentConstant.tourStep1Started, true);
                              jumpPage!(1);
                            } else if (index == 1 &&
                                controller.tourData.steps![0].isCompleted!) {
                              box.write(
                                  ArgumentConstant.tourStep2Started, true);
                              jumpPage!(2);
                            }
                          },
                    title: Text(
                      "Step ${index + 1}",
                      style: TextStyle(
                          fontSize: MySize.getHeight(12),
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade500),
                    ),
                    subtitle: Text(
                      controller.tourData.steps![index].title.toString(),
                      style: TextStyle(
                          fontSize: MySize.getHeight(13),
                          color: Colors.black,
                          decoration:
                              (controller.tourData.steps![index].isCompleted!)
                                  ? TextDecoration.lineThrough
                                  : null,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Container(
                      width: MySize.getWidth(70),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            (controller.tourData.steps![index].isCompleted!)
                                ? "Retake"
                                : 'Start',
                            style: TextStyle(
                                color: (index == 1 &&
                                        !controller
                                            .tourData.steps![0].isCompleted!)
                                    ? Color(0xffA6A6A6)
                                    : (index == 2 &&
                                            !controller.tourData.steps![0]
                                                .isCompleted! &&
                                            !controller.tourData.steps![1]
                                                .isCompleted!)
                                        ? Color(0xffA6A6A6)
                                        : (controller.tourData.steps![index]
                                                .isCompleted!)
                                            ? Color(0xffBD6A8D)
                                            : Color(0xff18AEAE),
                                fontWeight: FontWeight.w600),
                          ),
                          Spacing.width(5),
                          Icon(Icons.arrow_forward_ios,
                              size: MySize.getHeight(15),
                              color: (index == 1 &&
                                      !controller
                                          .tourData.steps![0].isCompleted!)
                                  ? Color(0xffA6A6A6)
                                  : (index == 2 &&
                                          !controller.tourData.steps![0]
                                              .isCompleted! &&
                                          !controller
                                              .tourData.steps![1].isCompleted!)
                                      ? Color(0xffA6A6A6)
                                      : (controller.tourData.steps![index]
                                              .isCompleted!)
                                          ? Color(0xffBD6A8D)
                                          : Color(0xff18AEAE)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            Spacing.height(10),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Toured (${controller.tourCompleted.value}/3)",
                    style: TextStyle(
                        color: appTheme.textColor,
                        fontSize: MySize.getHeight(10)),
                  ),
                  Container(
                    width: MySize.getWidth(220),
                    child: LinearPercentIndicator(
                      width: MySize.getWidth(215),
                      progressColor: Color(0xff18AEAE),
                      alignment: MainAxisAlignment.start,
                      animation: true,
                      animateFromLastPercent: true,
                      animationDuration: 600,
                      barRadius: Radius.circular(MySize.getHeight(10)),
                      percent: controller.tourCompleted.value / 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCompleteProfilePopUp(
      {required BuildContext context, required HomeController controller}) {
    return Padding(
      padding: EdgeInsets.only(left: MySize.getWidth(24)),
      child: Container(
        height: MySize.getHeight(145),
        width: MySize.screenWidth,
        decoration: BoxDecoration(
            color: ColorConstant.pink50A2,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(MySize.getHeight(20)),
                topLeft: Radius.circular(MySize.getHeight(20)))),
        padding: EdgeInsets.only(
            top: MySize.getHeight(25), left: MySize.getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complete your Profile",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MySize.getHeight(14),
              ),
            ),
            SizedBox(height: MySize.getHeight(8)),
            Row(
              children: [
                Text(
                  "Your Profile is incomplete. Get\ndone with it now",
                  style: TextStyle(
                      color: Color(0xffFF1A84), fontSize: MySize.getHeight(16)),
                ),
                SizedBox(width: MySize.getWidth(30)),
                SvgPicture.asset(
                  "assets/patient/play_icon.svg",
                  width: MySize.getWidth(11),
                  height: MySize.getHeight(17),
                ),
              ],
            ),
            SizedBox(height: MySize.getHeight(8)),
            InkWell(
              onTap: () {
                controller.skipProfileUpdate(context: context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: MySize.getHeight(5)),
                child: Text(
                  "SKIP",
                  style: TextStyle(
                      color: appTheme.pinkColor,
                      fontSize: MySize.getHeight(15),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MySize.getHeight(455),
              decoration: BoxDecoration(
                color: appTheme.lightPinkColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              margin: EdgeInsets.only(
                  left: MySize.getWidth(10), right: MySize.getWidth(10)),
              padding: EdgeInsets.only(
                  left: MySize.getWidth(8), right: MySize.getWidth(8)),
              child: Column(
                children: [
                  SizedBox(height: MySize.getHeight(5)),
                  Center(
                    child: SizedBox(
                      width: MySize.getWidth(24),
                      child: Divider(
                        color: Color(0xffC4C4C4),
                        thickness: MySize.getHeight(3),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(20)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today • 14 Oct 2021",
                      style: TextStyle(fontSize: MySize.getHeight(12)),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(20)),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(left: MySize.getWidth(20)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: MySize.getHeight(25),
                                      width: MySize.getWidth(25),
                                      child: SvgPicture.asset(
                                          "assets/image01.svg",
                                          fit: BoxFit.cover,
                                          height: MySize.getHeight(25),
                                          width: MySize.getWidth(25)),
                                    ),
                                    SizedBox(width: MySize.getWidth(22)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ankitha Sharma",
                                          style: TextStyle(
                                              fontSize: MySize.getHeight(17),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: MySize.getHeight(2)),
                                        Text(
                                          "Egg Retrieval  •  Egg Donor",
                                          style: TextStyle(
                                              fontSize: MySize.getHeight(13),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: MySize.getHeight(2)),
                                        Text(
                                          "11 AM  |  Sarayu Clinic",
                                          style: TextStyle(
                                              fontSize: MySize.getHeight(12),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: MySize.getHeight(10)),
                                Divider(),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: MySize.getHeight(5),
                          );
                        },
                        itemCount: 10),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
