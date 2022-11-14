import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/theme/app_style.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../routes/app_pages.dart';
import '../../create_procedure_customise/views/create_procedure_customise_view.dart';
import '../controllers/patients_controller.dart';

class PatientsView extends GetWidget<PatientsController> {
  PatientsView({this.jumpPage});
  Function(int)? jumpPage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientsController>(
        init: PatientsController(),
        builder: (controller) {
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
                      (_) => Future.delayed(Duration(milliseconds: 300), () {
                        ShowCaseWidget.of(context).startShowCase(
                            [controller.addPatientShowCaseKey.value]);
                      }),
                    );
                  }
                  if (!box.read(ArgumentConstant.tourStep2Started) &&
                      box.read(ArgumentConstant.tourStep2Completed) &&
                      controller.tourViewed.isFalse) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Future.delayed(Duration(milliseconds: 300), () {
                        ShowCaseWidget.of(context).startShowCase(
                            [controller.newlyAddedPatientShowCaseKey.value]);
                      }),
                    );
                  }
                  return Scaffold(
                    body: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.red50,
                          border: Border.all(
                            color: ColorConstant.black90033,
                            width: MySize.getWidth(0.50),
                          ),
                        ),
                        child: (controller.hasData.isFalse)
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: appTheme.primaryTheme),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MySize.getHeight(140),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.pink50A2,
                                    ),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: MySize.screenWidth,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: MySize.getHeight(6),
                                                left: MySize.getWidth(8),
                                                right: MySize.getWidth(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/logo0101.svg",
                                                        color: appTheme
                                                            .primaryTheme,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.getWidth(
                                                              12),
                                                          bottom:
                                                              MySize.getHeight(
                                                                  0),
                                                        ),
                                                        child: Text(
                                                          "My Patients",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .textStyleDMSansmedium16
                                                              .copyWith(
                                                            fontSize: MySize
                                                                .getHeight(16),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Showcase(
                                                    key: controller
                                                        .addPatientShowCaseKey
                                                        .value,
                                                    description:
                                                        "Tap here to add patient to the selecteed procedure",
                                                    disposeOnTap: true,
                                                    onTargetClick: () async {
                                                      controller.tourViewed
                                                          .value = true;
                                                      final PermissionStatus
                                                          permissionStatus =
                                                          await _getPermission();
                                                      print(permissionStatus);
                                                      if (permissionStatus
                                                          .isGranted) {
                                                        Get.toNamed(Routes
                                                            .CONTACT_SCREEN);
                                                      }
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final PermissionStatus
                                                            permissionStatus =
                                                            await _getPermission();
                                                        print(permissionStatus);
                                                        if (permissionStatus
                                                            .isGranted) {
                                                          Get.toNamed(Routes
                                                              .CONTACT_SCREEN);
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                offset: Offset(
                                                                    2, 2),
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius:
                                                                    MySize
                                                                        .size2!,
                                                                spreadRadius:
                                                                    MySize
                                                                        .size2!,
                                                              ),
                                                              BoxShadow(
                                                                offset: Offset(
                                                                    -1, -1),
                                                                color: Colors
                                                                    .white,
                                                                blurRadius:
                                                                    MySize
                                                                        .size2!,
                                                                spreadRadius:
                                                                    MySize
                                                                        .size2!,
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2000),
                                                            color: appTheme
                                                                .shadowColor),
                                                        height:
                                                            MySize.getHeight(
                                                                36),
                                                        width:
                                                            MySize.getWidth(36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: SvgPicture.asset(
                                                          "assets/add_pati.svg",
                                                          height:
                                                              MySize.getHeight(
                                                                  18),
                                                          width:
                                                              MySize.getWidth(
                                                                  18),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MySize.getWidth(10)),
                                                  // Stack(
                                                  //   alignment: Alignment.center,
                                                  //   children: [
                                                  //     Container(
                                                  //       height: MySize.getHeight(36),
                                                  //       width: MySize.getWidth(36),
                                                  //       decoration: BoxDecoration(
                                                  //           boxShadow: [
                                                  //             BoxShadow(
                                                  //               offset: Offset(2, 2),
                                                  //               color: Colors.black26,
                                                  //               blurRadius:
                                                  //                   MySize.size2!,
                                                  //               spreadRadius:
                                                  //                   MySize.size2!,
                                                  //             ),
                                                  //             BoxShadow(
                                                  //               offset: Offset(-1, -1),
                                                  //               color: Colors.white,
                                                  //               blurRadius:
                                                  //                   MySize.size2!,
                                                  //               spreadRadius:
                                                  //                   MySize.size2!,
                                                  //             ),
                                                  //           ],
                                                  //           borderRadius:
                                                  //               BorderRadius.circular(
                                                  //                   2000),
                                                  //           color:
                                                  //               appTheme.shadowColor),
                                                  //     ),
                                                  //     SvgPicture.asset(
                                                  //       "assets/noti_01.svg",
                                                  //       fit: BoxFit.cover,
                                                  //       height: MySize.getHeight(55),
                                                  //       width: MySize.getWidth(55),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: MySize.getHeight(36)),
                                        if (!isNullEmptyOrFalse(
                                            controller.procedureTypesList))
                                          getAllProcedureListing(
                                              context: context,
                                              controller: controller),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child:
                                        (isNullEmptyOrFalse(
                                                controller.patientsList))
                                            ? Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          MySize.getWidth(15)),
                                                  child: Text(
                                                    "No patients assigned for this procedure.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            appTheme.textColor,
                                                        fontSize:
                                                            MySize.getHeight(
                                                                18)),
                                                  ),
                                                ),
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    ScrollablePositionedList
                                                        .separated(
                                                      itemScrollController:
                                                          controller
                                                              .itemScrollController2,
                                                      itemCount: controller
                                                          .patientsList.length,
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              MySize.getHeight(
                                                                  45)),
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (timeStamp) {
                                                          if (controller
                                                              .isPatientViewed
                                                              .isFalse) {
                                                            controller
                                                                .patientsList
                                                                .forEach(
                                                                    (element) {
                                                              if (element
                                                                      .patient!
                                                                      .patient!
                                                                      .userDbId ==
                                                                  controller
                                                                      .addedPatientDbId
                                                                      .value) {
                                                                controller.itemScrollController2.scrollTo(
                                                                    index: controller
                                                                        .patientsList
                                                                        .indexOf(
                                                                            element),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            200));
                                                                controller
                                                                    .isPatientViewed
                                                                    .value = true;
                                                              }
                                                            });
                                                          }
                                                        });
                                                        if (box.read(
                                                                ArgumentConstant
                                                                    .tourStep2Completed) &&
                                                            controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .patient!
                                                                    .userDbId ==
                                                                controller
                                                                    .addedPatientDbId
                                                                    .value &&
                                                            !isNullEmptyOrFalse(
                                                                controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .msCycleStartDateTime) &&
                                                            (controller
                                                                .patientsList[
                                                                    index]
                                                                .patient!
                                                                .isProcedureStarted) &&
                                                            !controller
                                                                .patientsList[
                                                                    index]
                                                                .isYetToStart) {
                                                          return getNewlyAddedPatientTrackerCardForTour(
                                                              context: context,
                                                              controller:
                                                                  controller,
                                                              index: index);
                                                        } else if (box.read(
                                                                ArgumentConstant
                                                                    .tourStep3Started) &&
                                                            controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .patient!
                                                                    .userDbId ==
                                                                controller
                                                                    .addedPatientDbId
                                                                    .value &&
                                                            !isNullEmptyOrFalse(
                                                                controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .msCycleStartDateTime) &&
                                                            (controller
                                                                .patientsList[
                                                                    index]
                                                                .patient!
                                                                .isProcedureStarted) &&
                                                            !controller
                                                                .patientsList[
                                                                    index]
                                                                .isYetToStart) {
                                                          return getNewlyAddedPatientTrackerCardForTour2(
                                                              context: context,
                                                              controller:
                                                                  controller,
                                                              index: index);
                                                        }

                                                        return ((!isNullEmptyOrFalse(controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .msCycleStartDateTime) &&
                                                                (controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .isProcedureStarted) &&
                                                                !controller
                                                                    .patientsList[
                                                                        index]
                                                                    .isYetToStart)
                                                            ? getPatientTrackerCard(
                                                                context:
                                                                    context,
                                                                controller:
                                                                    controller,
                                                                index: index)
                                                            : SizedBox());
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          height:
                                                              MySize.getHeight(
                                                                  5),
                                                        );
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MySize.getWidth(
                                                              18)),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Yet to start",
                                                          style: TextStyle(
                                                              color: appTheme
                                                                  .pinkColor,
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      13),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacing.height(18),
                                                    ScrollablePositionedList
                                                        .separated(
                                                      itemScrollController:
                                                          controller
                                                              .itemScrollController3,
                                                      itemCount: controller
                                                          .patientsList.length,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (timeStamp) {
                                                          if (controller
                                                              .isPatientViewed
                                                              .isFalse) {
                                                            controller
                                                                .patientsList
                                                                .forEach(
                                                                    (element) {
                                                              print(
                                                                  "patient Db Id := ${element.patient!.patient!.userDbId} ====> ${controller.addedPatientDbId.value}");
                                                              if (element
                                                                      .patient!
                                                                      .patient!
                                                                      .userDbId ==
                                                                  controller
                                                                      .addedPatientDbId
                                                                      .value) {
                                                                controller.itemScrollController3.scrollTo(
                                                                    index: controller
                                                                        .patientsList
                                                                        .indexOf(
                                                                            element),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            200));
                                                                controller
                                                                    .isPatientViewed
                                                                    .value = true;
                                                              }
                                                            });
                                                          }
                                                        });

                                                        return ((isNullEmptyOrFalse(controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .msCycleStartDateTime) ||
                                                                (!controller
                                                                    .patientsList[
                                                                        index]
                                                                    .patient!
                                                                    .isProcedureStarted) ||
                                                                controller
                                                                    .patientsList[
                                                                        index]
                                                                    .isYetToStart)
                                                            ? Container(
                                                                child: Card(
                                                                  elevation: 2,
                                                                  color: (controller
                                                                              .patientsList[
                                                                                  index]
                                                                              .patient!
                                                                              .patient!
                                                                              .userDbId ==
                                                                          controller
                                                                              .addedPatientDbId
                                                                              .value)
                                                                      ? Color(
                                                                          0xffFFE2F4)
                                                                      : appTheme
                                                                          .lightPinkColor,
                                                                  child:
                                                                      ListTile(
                                                                    onTap: () {
                                                                      box.write(
                                                                          ArgumentConstant
                                                                              .getUserDbId,
                                                                          controller
                                                                              .patientsList[index]
                                                                              .patient!
                                                                              .patient!
                                                                              .userDbId);
                                                                      Get.toNamed(
                                                                          Routes
                                                                              .PATIENT_TRACKER_SCREEN,
                                                                          arguments: {
                                                                            ArgumentConstant.patientProcedureDbId:
                                                                                controller.patientsList[index].patient!.id,
                                                                            ArgumentConstant.msCycleStartDate: (!isNullEmptyOrFalse(controller.patientsList[index].patient!.previousMsCycle))
                                                                                ? controller.patientsList[index].patient!.previousMsCycle
                                                                                : "",
                                                                          });
                                                                    },
                                                                    leading:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          appTheme
                                                                              .pinkColor,
                                                                      child:
                                                                          Text(
                                                                        getFirstTwoLetterCapital(
                                                                            text:
                                                                                controller.patientsList[index].patient!.patient!.name!),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    title: Text(
                                                                      controller
                                                                          .patientsList[
                                                                              index]
                                                                          .patient!
                                                                          .patient!
                                                                          .name!,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      "${controller.patientsList[index].patient!.procedure!.name!}  |  Surrogate",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                    trailing:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MySize.getWidth(55),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              if (controller.patientsList[index].patient!.status == "Enrolled")
                                                                                SvgPicture.asset("assets/enrolled_icon.svg", width: MySize.getWidth(55)),
                                                                              if (controller.patientsList[index].patient!.status == "Invited")
                                                                                SvgPicture.asset("assets/invited_icon.svg", width: MySize.getWidth(55)),
                                                                              if (controller.patientsList[index].patient!.status == "Profiled")
                                                                                SvgPicture.asset("assets/profiled_icon.svg", width: MySize.getWidth(55)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        if (!isNullEmptyOrFalse(controller
                                                                            .patientsList[index]
                                                                            .patient!
                                                                            .msCycleStart))
                                                                          Text(
                                                                            DateFormat("dd, MMM yyyy").format(DateFormat("dd MMMM yyyy").parse(controller.patientsList[index].patient!.msCycleStart!)),
                                                                            style:
                                                                                TextStyle(fontSize: MySize.getHeight(12)),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox());
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          height:
                                                              MySize.getHeight(
                                                                  1),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                      );
                    }),
                  );
                },
              ));
        });
  }

  // PatientTrackerCard

  getNewlyAddedPatientTrackerCardForTour(
      {required BuildContext context,
      required PatientsController controller,
      required int index}) {
    return Showcase.withWidget(
      key: controller.newlyAddedPatientShowCaseKey.value,
      height: MySize.getHeight(40),
      width: MySize.getWidth(250),
      onTargetClick: () {},
      container: Stack(
        children: [
          Positioned(
            right: MySize.getWidth(20),
            child: CustomPaint(
              painter: Arrow(
                strokeColor: Colors.white,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
                isUpArrow: true,
              ),
              child: SizedBox(
                height: MySize.getHeight(9),
                width: MySize.getWidth(18),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: MySize.getHeight(9)),
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.getWidth(20),
                  vertical: MySize.getHeight(5)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MySize.getHeight(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MySize.getWidth(250),
                    child: Text(
                        "Congratulations. Your First Patient is added to the procedure.\n\nYou can add as many patients and track their progress."),
                  ),
                  SizedBox(
                    height: MySize.getHeight(15),
                    width: MySize.getWidth(240),
                    child: Divider(),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.tourViewed.value = true;

                      ShowCaseWidget.of(context).next();
                      controller.updateTourStepApi(context: context);
                    },
                    child: SizedBox(
                      height: MySize.getHeight(50),
                      width: MySize.getWidth(260),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Step 3",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(11),
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Track your patient schedules",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(13),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "Start",
                            style: TextStyle(color: Color(0xff18AEAE)),
                          ),
                          Spacing.width(5),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff18AEAE),
                            size: MySize.getHeight(13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacing.height(10),
                ],
              ),
            ),
          ),
        ],
      ),
      overlayPadding: EdgeInsets.symmetric(
          vertical: MySize.getHeight(10), horizontal: MySize.getWidth(10)),
      overlayColor: Colors.transparent,
      overlayOpacity: 0.2,
      showcaseBackgroundColor: Colors.white,
      child: Container(
        child: Card(
          elevation: 2,
          color: (controller.patientsList[index].patient!.patient!.userDbId ==
                  controller.addedPatientDbId.value)
              ? Color(0xffFFE2F4)
              : appTheme.lightPinkColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: MySize.getHeight(10)),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    box.write(
                        ArgumentConstant.getUserDbId,
                        controller
                            .patientsList[index].patient!.patient!.userDbId);
                    Get.toNamed(Routes.PATIENT_TRACKER_SCREEN, arguments: {
                      ArgumentConstant.patientProcedureDbId:
                          controller.patientsList[index].patient!.id,
                      ArgumentConstant.msCycleStartDate: (!isNullEmptyOrFalse(
                              controller
                                  .patientsList[index].patient!.msCycleStart))
                          ? controller.patientsList[index].patient!.msCycleStart
                          : "",
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: appTheme.pinkColor,
                    child: Text(
                      getFirstTwoLetterCapital(
                          text: controller
                              .patientsList[index].patient!.patient!.name!),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    controller.patientsList[index].patient!.patient!.name!,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.patientsList[index].patient!.procedure!.name!}  |  Surrogate",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                      ),
                      Spacing.height(5),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isNullEmptyOrFalse(
                          controller.patientsList[index].events))
                        Container(
                          child: Text(
                            controller.patientsList[index].events![0].events![0]
                                .eventName!
                                .toString()
                                .trim(),
                            style: TextStyle(
                                fontSize: MySize.getHeight(10),
                                color: appTheme.primaryTheme),
                          ),
                        ),
                      Spacing.height(2),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacing.width(60),
                    if (!isNullEmptyOrFalse(
                        controller.patientsList[index].events))
                      LinearPercentIndicator(
                        width: MySize.getWidth(170),
                        progressColor: appTheme.pinkColor,
                        alignment: MainAxisAlignment.start,
                        barRadius: Radius.circular(MySize.getHeight(10)),
                        percent: controller
                                .patientsList[index].events![0].day! /
                            (controller.patientsList[index].events!.last.day!),
                      ),
                    Spacer(),
                    if (!isNullEmptyOrFalse(controller
                            .patientsList[index].patient!.msCycleStart) &&
                        !isNullEmptyOrFalse(
                            controller.patientsList[index].events))
                      Text(
                        "Day ${controller.patientsList[index].events![0].day!}",
                        style: TextStyle(fontSize: MySize.getHeight(12)),
                      ),
                    Spacing.width(15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getNewlyAddedPatientTrackerCardForTour2(
      {required BuildContext context,
      required PatientsController controller,
      required int index}) {
    return Showcase.withWidget(
      key: controller.newlyAddedPatientShowCaseKey2.value,
      height: MySize.getHeight(40),
      width: MySize.getWidth(250),
      onTargetClick: () {
        ShowCaseWidget.of(context).next();
        box.write(ArgumentConstant.getUserDbId,
            controller.patientsList[index].patient!.patient!.userDbId);
        Get.toNamed(Routes.PATIENT_TRACKER_SCREEN, arguments: {
          ArgumentConstant.patientProcedureDbId:
              controller.patientsList[index].patient!.id,
          ArgumentConstant.msCycleStartDate: (!isNullEmptyOrFalse(
                  controller.patientsList[index].patient!.msCycleStart))
              ? controller.patientsList[index].patient!.msCycleStart
              : "",
        });
      },
      overlayPadding: EdgeInsets.symmetric(
          vertical: MySize.getHeight(10), horizontal: MySize.getWidth(10)),
      overlayColor: Colors.transparent,
      overlayOpacity: 0.2,
      showcaseBackgroundColor: Colors.white,
      container: Stack(
        children: [
          Positioned(
            right: MySize.getWidth(20),
            child: CustomPaint(
              painter: Arrow(
                strokeColor: Colors.white,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
                isUpArrow: true,
              ),
              child: SizedBox(
                height: MySize.getHeight(9),
                width: MySize.getWidth(18),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: MySize.getHeight(9)),
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.getWidth(20),
                  vertical: MySize.getHeight(5)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MySize.getHeight(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MySize.getWidth(250),
                    child: Text(
                        "Tap on the patient card to track all the details."),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: Container(
        child: Card(
          elevation: 2,
          color: (controller.patientsList[index].patient!.patient!.userDbId ==
                  controller.addedPatientDbId.value)
              ? Color(0xffFFE2F4)
              : appTheme.lightPinkColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: MySize.getHeight(10)),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    box.write(
                        ArgumentConstant.getUserDbId,
                        controller
                            .patientsList[index].patient!.patient!.userDbId);
                    Get.toNamed(Routes.PATIENT_TRACKER_SCREEN, arguments: {
                      ArgumentConstant.patientProcedureDbId:
                          controller.patientsList[index].patient!.id,
                      ArgumentConstant.msCycleStartDate: (!isNullEmptyOrFalse(
                              controller
                                  .patientsList[index].patient!.msCycleStart))
                          ? controller.patientsList[index].patient!.msCycleStart
                          : "",
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: appTheme.pinkColor,
                    child: Text(
                      getFirstTwoLetterCapital(
                          text: controller
                              .patientsList[index].patient!.patient!.name!),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    controller.patientsList[index].patient!.patient!.name!,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.patientsList[index].patient!.procedure!.name!}  |  Surrogate",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                      ),
                      Spacing.height(5),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isNullEmptyOrFalse(
                          controller.patientsList[index].events))
                        Container(
                          child: Text(
                            controller.patientsList[index].events![0].events![0]
                                .eventName!
                                .toString()
                                .trim(),
                            style: TextStyle(
                                fontSize: MySize.getHeight(10),
                                color: appTheme.primaryTheme),
                          ),
                        ),
                      Spacing.height(2),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacing.width(60),
                    if (!isNullEmptyOrFalse(
                        controller.patientsList[index].events))
                      LinearPercentIndicator(
                        width: MySize.getWidth(170),
                        progressColor: appTheme.pinkColor,
                        alignment: MainAxisAlignment.start,
                        barRadius: Radius.circular(MySize.getHeight(10)),
                        percent: controller
                                .patientsList[index].events![0].day! /
                            (controller.patientsList[index].events!.last.day!),
                      ),
                    Spacer(),
                    if (!isNullEmptyOrFalse(controller
                            .patientsList[index].patient!.msCycleStart) &&
                        !isNullEmptyOrFalse(
                            controller.patientsList[index].events))
                      Text(
                        "Day ${controller.patientsList[index].events![0].day!}",
                        style: TextStyle(fontSize: MySize.getHeight(12)),
                      ),
                    Spacing.width(15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPatientTrackerCard(
      {required BuildContext context,
      required PatientsController controller,
      required int index}) {
    return Container(
      child: Card(
        elevation: 2,
        color: (controller.patientsList[index].patient!.patient!.userDbId ==
                controller.addedPatientDbId.value)
            ? Color(0xffFFE2F4)
            : appTheme.lightPinkColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: MySize.getHeight(10)),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  box.write(
                      ArgumentConstant.getUserDbId,
                      controller
                          .patientsList[index].patient!.patient!.userDbId);
                  Get.toNamed(Routes.PATIENT_TRACKER_SCREEN, arguments: {
                    ArgumentConstant.patientProcedureDbId:
                        controller.patientsList[index].patient!.id,
                    ArgumentConstant.msCycleStartDate: (!isNullEmptyOrFalse(
                            controller
                                .patientsList[index].patient!.msCycleStart))
                        ? controller.patientsList[index].patient!.msCycleStart
                        : "",
                  });
                },
                leading: CircleAvatar(
                  backgroundColor: appTheme.pinkColor,
                  child: Text(
                    getFirstTwoLetterCapital(
                        text: controller
                            .patientsList[index].patient!.patient!.name!),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  controller.patientsList[index].patient!.patient!.name!,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.patientsList[index].patient!.procedure!.name!}  |  Surrogate",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                    Spacing.height(5),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isNullEmptyOrFalse(
                        controller.patientsList[index].events))
                      Container(
                        child: Text(
                          controller.patientsList[index].events![0].events![0]
                              .eventName!
                              .toString()
                              .trim(),
                          style: TextStyle(
                              fontSize: MySize.getHeight(10),
                              color: appTheme.primaryTheme),
                        ),
                      ),
                    Spacing.height(2),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacing.width(60),
                  if (!isNullEmptyOrFalse(
                      controller.patientsList[index].events))
                    LinearPercentIndicator(
                      width: MySize.getWidth(170),
                      progressColor: appTheme.pinkColor,
                      alignment: MainAxisAlignment.start,
                      barRadius: Radius.circular(MySize.getHeight(10)),
                      percent: controller.patientsList[index].events![0].day! /
                          (controller.patientsList[index].events!.last.day!),
                    ),
                  Spacer(),
                  if (!isNullEmptyOrFalse(controller
                          .patientsList[index].patient!.msCycleStart) &&
                      !isNullEmptyOrFalse(
                          controller.patientsList[index].events))
                    Text(
                      "Day ${controller.patientsList[index].events![0].day!}",
                      style: TextStyle(fontSize: MySize.getHeight(12)),
                    ),
                  Spacing.width(15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //PatientTrackerCard

  Widget getAllProcedureListing(
      {required BuildContext context, required PatientsController controller}) {
    return Container(
      width: MySize.getWidth(360),
      height: MySize.getHeight(41),
      child: ScrollablePositionedList.separated(
        itemScrollController: controller.itemScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.procedureTypesList.length,
        padding: EdgeInsets.symmetric(
            vertical: MySize.getHeight(5), horizontal: MySize.getWidth(10)),
        itemBuilder: (context, index) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (controller.isProcedureViewed.isFalse) {
              controller.procedureTypesList.forEach((element) {
                if (element.id == controller.addedPatientProcedureDbId.value) {
                  controller.itemScrollController.scrollTo(
                      index: controller.procedureTypesList.indexOf(element),
                      duration: Duration(milliseconds: 200));
                }
              });
              controller.isProcedureViewed.value = true;
            }
          });
          return Obx(() {
            return InkWell(
              onTap: () {
                controller.procedureTypesList.forEach((element) {
                  element.isSelected!.value = false;
                });
                controller.procedureTypesList[index].isSelected!.value = true;
                controller.getPatientsByProcedureName(
                    procedureName: controller.procedureTypesList[index].name!);
              },
              child: Container(
                height: MySize.getHeight(33),
                padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(10)),
                decoration: BoxDecoration(
                    // border: Border.all(
                    //     color: (controller
                    //             .procedureTypesList[index].isSelected!.value)
                    //         ? appTheme.primaryTheme
                    //         : Colors.transparent,
                    //     width: MySize.getHeight(2)),
                    boxShadow:
                        (controller.procedureTypesList[index].isSelected!.value)
                            ? appTheme.getShadow3
                            : null,
                    color:
                        (controller.procedureTypesList[index].isSelected!.value)
                            ? appTheme.pink50A2
                            : Colors.white,
                    borderRadius: BorderRadius.circular(MySize.getHeight(10))),
                alignment: Alignment.center,
                child: Text(
                  controller.procedureTypesList[index].name!,
                  style: TextStyle(
                      color: (controller
                              .procedureTypesList[index].isSelected!.value)
                          ? appTheme.pinkColor
                          : appTheme.primaryTheme,
                      fontSize: MySize.getHeight(13),
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          });
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: MySize.getWidth(13));
        },
      ),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    print(permission);
    if (!(await Permission.contacts.isGranted)) {
      permission = await Permission.contacts.request();
    }
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}
