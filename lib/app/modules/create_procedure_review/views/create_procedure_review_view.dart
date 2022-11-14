import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../create_procedure_customise/views/create_procedure_customise_view.dart';
import '../controllers/create_procedure_review_controller.dart';

class CreateProcedureReviewView
    extends GetWidget<CreateProcedureReviewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProcedureReviewController>(
        init: CreateProcedureReviewController(),
        builder: (controller) {
          return ShowCaseWidget(
              disableBarrierInteraction: true,
              onFinish: () {
                // controller.tourViewed.value = true;
              },
              builder: Builder(
                builder: (context) {
                  if (controller.isTourStarted.value &&
                      controller.tourViewed.isFalse) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Future.delayed(Duration(milliseconds: 0), () {
                        ShowCaseWidget.of(context).startShowCase(
                            [controller.reviewShowCaseKey.value]);
                      }),
                    );
                  }
                  if (box.read(ArgumentConstant.tourStep2Started) &&
                      controller.tourViewed.isFalse) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Future.delayed(Duration(milliseconds: 0), () {
                        ShowCaseWidget.of(context)
                            .startShowCase([controller.editShowCaseKey.value]);
                      }),
                    );
                  }
                  controller.scrollController.addListener(() {
                    if (controller.scrollController.position.pixels ==
                        controller.scrollController.position.maxScrollExtent) {
                      controller.isWholeProcedureReview.value = true;
                    }
                  });

                  return SafeArea(
                    child: Obx(() {
                      return Scaffold(
                        backgroundColor: ColorConstant.red50,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView(
                                controller: controller.scrollController,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: MySize.getHeight(27)),
                                        decoration: BoxDecoration(
                                            color: ColorConstant.red50,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(4, 4),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                  color: Colors.black
                                                      .withOpacity(0.1))
                                            ],
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    MySize.getHeight(50)),
                                                bottomRight: Radius.circular(
                                                    MySize.getHeight(50)))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (controller
                                                    .isAddedPatients.value ||
                                                controller.isProcedureView)
                                              SizedBox(
                                                  height: MySize.getHeight(34)),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width: MySize.getWidth(17)),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    color: Colors.black,
                                                    size: MySize.getHeight(25),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MySize.getWidth(15)),
                                                SizedBox(
                                                  width: MySize.getWidth(190),
                                                  child: Text(
                                                    (controller.isProcedureView)
                                                        ? (!isNullEmptyOrFalse(
                                                                controller
                                                                    .procedureName))
                                                            ? controller
                                                                .procedureName
                                                            : "Preview Procedure"
                                                        : (controller
                                                                .isAddedPatients
                                                                .isTrue)
                                                            ? "Review Schedule"
                                                            : (!isNullEmptyOrFalse(
                                                                    controller
                                                                        .procedureName))
                                                                ? "Review ${controller.procedureName}"
                                                                : "Review Procedure",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            MySize.getHeight(
                                                                16),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Spacer(),
                                                if (controller.isAddedPatients
                                                        .isFalse &&
                                                    !controller.isProcedureView)
                                                  SvgPicture.asset(
                                                      "assets/egg_pic02.svg"),
                                                if (controller
                                                    .isAddedPatients.isTrue)
                                                  Showcase.withWidget(
                                                    key: controller
                                                        .editShowCaseKey.value,
                                                    height:
                                                        MySize.getHeight(40),
                                                    width: MySize.getWidth(250),
                                                    onTargetClick: () {
                                                      controller.tourViewed
                                                          .value = true;
                                                      Get.toNamed(
                                                          Routes
                                                              .CREATE_PROCEDURE_CUSTOMISE,
                                                          arguments: {
                                                            ArgumentConstant
                                                                    .isForAddedPatient:
                                                                true,
                                                            ArgumentConstant
                                                                    .addedPatientProcedureDbId:
                                                                controller
                                                                    .addedPatientProcedureDbId
                                                                    .value,
                                                            ArgumentConstant
                                                                    .addedPatientDbId:
                                                                controller
                                                                    .addedPatientDbId
                                                                    .value,
                                                            ArgumentConstant
                                                                    .addedPatientName:
                                                                controller
                                                                    .patientName
                                                                    .value,
                                                            ArgumentConstant
                                                                    .addedPatientProcedureName:
                                                                controller
                                                                    .patientProcedureName
                                                                    .value,
                                                            ArgumentConstant
                                                                    .msCycleStartDate:
                                                                controller
                                                                    .msCycleStartDate,
                                                            ArgumentConstant
                                                                    .procedureDbId:
                                                                controller
                                                                    .procedureDbId,
                                                          });
                                                      ShowCaseWidget.of(context)
                                                          .next();
                                                    },
                                                    container: Stack(
                                                      children: [
                                                        Positioned(
                                                          right:
                                                              MySize.getWidth(
                                                                  20),
                                                          child: CustomPaint(
                                                            painter: Arrow(
                                                              strokeColor:
                                                                  Colors.white,
                                                              strokeWidth: 10,
                                                              paintingStyle:
                                                                  PaintingStyle
                                                                      .fill,
                                                              isUpArrow: true,
                                                            ),
                                                            child: SizedBox(
                                                              height: MySize
                                                                  .getHeight(9),
                                                              width: MySize
                                                                  .getWidth(18),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
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
                                                                borderRadius: BorderRadius
                                                                    .circular(MySize
                                                                        .getHeight(
                                                                            10))),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: MySize
                                                                      .getWidth(
                                                                          200),
                                                                  child: Text(
                                                                      "If this patient needs any adjustments from your regular procedure, you can make them here. This wont effect the actual defined parocedure or other patients."),
                                                                ),
                                                                Spacing.height(
                                                                    5),
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .tourViewed
                                                                        .value = true;
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .CREATE_PROCEDURE_CUSTOMISE,
                                                                        arguments: {
                                                                          ArgumentConstant.isForAddedPatient:
                                                                              true,
                                                                          ArgumentConstant.addedPatientProcedureDbId: controller
                                                                              .addedPatientProcedureDbId
                                                                              .value,
                                                                          ArgumentConstant.addedPatientDbId: controller
                                                                              .addedPatientDbId
                                                                              .value,
                                                                          ArgumentConstant.addedPatientName: controller
                                                                              .patientName
                                                                              .value,
                                                                          ArgumentConstant.addedPatientProcedureName: controller
                                                                              .patientProcedureName
                                                                              .value,
                                                                          ArgumentConstant.msCycleStartDate:
                                                                              controller.msCycleStartDate,
                                                                          ArgumentConstant.procedureDbId:
                                                                              controller.procedureDbId,
                                                                        });
                                                                    ShowCaseWidget.of(
                                                                            context)
                                                                        .next();
                                                                  },
                                                                  child: Text(
                                                                    "NEXT",
                                                                    style: TextStyle(
                                                                        color: appTheme
                                                                            .primaryTheme),
                                                                  ),
                                                                ),
                                                                Spacing.height(
                                                                    5),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    overlayPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: MySize
                                                                .getHeight(10),
                                                            horizontal:
                                                                MySize.getWidth(
                                                                    10)),
                                                    overlayColor:
                                                        Colors.transparent,
                                                    overlayOpacity: 0.2,
                                                    showcaseBackgroundColor:
                                                        Colors.white,
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (controller
                                                            .isProcedureView) {
                                                          Get.offAndToNamed(
                                                              Routes
                                                                  .CREATE_PROCEDURE_CUSTOMISE,
                                                              arguments: {
                                                                ArgumentConstant
                                                                        .isProcedureView:
                                                                    true,
                                                                ArgumentConstant
                                                                        .procedureDbId:
                                                                    controller
                                                                        .procedureDbId,
                                                              });
                                                        } else {
                                                          Get.toNamed(
                                                              Routes
                                                                  .CREATE_PROCEDURE_CUSTOMISE,
                                                              arguments: {
                                                                ArgumentConstant
                                                                        .isForAddedPatient:
                                                                    true,
                                                                ArgumentConstant
                                                                        .addedPatientProcedureDbId:
                                                                    controller
                                                                        .addedPatientProcedureDbId
                                                                        .value,
                                                                ArgumentConstant
                                                                        .addedPatientDbId:
                                                                    controller
                                                                        .addedPatientDbId
                                                                        .value,
                                                                ArgumentConstant
                                                                        .addedPatientName:
                                                                    controller
                                                                        .patientName
                                                                        .value,
                                                                ArgumentConstant
                                                                        .addedPatientProcedureName:
                                                                    controller
                                                                        .patientProcedureName
                                                                        .value,
                                                                ArgumentConstant
                                                                        .msCycleStartDate:
                                                                    controller
                                                                        .msCycleStartDate,
                                                                ArgumentConstant
                                                                        .procedureDbId:
                                                                    controller
                                                                        .procedureDbId,
                                                              });
                                                        }
                                                      },
                                                      child: Neumorphic(
                                                        style: NeumorphicStyle(
                                                          depth: 10,
                                                          color: appTheme
                                                              .backgroundTheme,
                                                          boxShape:
                                                              NeumorphicBoxShape
                                                                  .roundRect(
                                                            BorderRadius
                                                                .circular(
                                                              MySize.getHeight(
                                                                  10),
                                                            ),
                                                          ),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right:
                                                                MySize.getWidth(
                                                                    20)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: MySize
                                                                    .getWidth(
                                                                        16),
                                                                vertical: MySize
                                                                    .getHeight(
                                                                        7)),
                                                        child: Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffBD6A8D),
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      12)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(
                                                    (controller.isAddedPatients
                                                                .isTrue ||
                                                            controller
                                                                .isProcedureView)
                                                        ? 20
                                                        : 10)),
                                            if (controller
                                                .isAddedPatients.isTrue)
                                              Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      height:
                                                          MySize.getHeight(48),
                                                      width:
                                                          MySize.getWidth(48),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffA76488),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        (!isNullEmptyOrFalse(
                                                                controller
                                                                    .patientName
                                                                    .value))
                                                            ? (controller
                                                                        .patientName
                                                                        .value
                                                                        .length ==
                                                                    1)
                                                                ? controller
                                                                    .patientName
                                                                    .toUpperCase()
                                                                : (controller
                                                                            .patientName
                                                                            .value
                                                                            .length >=
                                                                        2)
                                                                    ? "${controller.patientName.value[0].toUpperCase()}${controller.patientName.value[1].toUpperCase()}"
                                                                    : "gkg"
                                                            : "gsg",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MySize
                                                                .getHeight(16)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MySize.getHeight(12)),
                                                  Center(
                                                    child: Text(
                                                      controller
                                                          .patientName.value,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize:
                                                            MySize.getHeight(
                                                                16),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      controller
                                                          .patientProcedureName
                                                          .value,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            MySize.getHeight(
                                                                15),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (controller
                                                .isAddedPatients.isTrue)
                                              SizedBox(
                                                  height: MySize.getHeight(33)),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MySize.getWidth(40)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      (controller
                                                              .isAddedPatients
                                                              .isTrue)
                                                          ? "LMP"
                                                          : "Define",
                                                      style: TextStyle(
                                                          color: appTheme
                                                              .primaryTheme,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              MySize.getHeight(
                                                                  14)),
                                                    ),
                                                    Text(
                                                      (controller
                                                              .isAddedPatients
                                                              .isTrue)
                                                          ? "Procedure"
                                                          : "Customise",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffBD6A8D),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              MySize.getHeight(
                                                                  14)),
                                                    ),
                                                    Text(
                                                      (controller
                                                              .isAddedPatients
                                                              .isTrue)
                                                          ? "Team"
                                                          : "Review",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffBD6A8D),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              MySize.getHeight(
                                                                  14)),
                                                    ),
                                                  ]),
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(16)),
                                            Center(
                                              child: Image(
                                                image: AssetImage((controller
                                                        .isAddedPatients.isTrue)
                                                    ? "assets/Tack_02.png"
                                                    : "assets/Track03.png"),
                                                width: MySize.getWidth(281),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(0)),
                                          ],
                                        ),
                                      ),
                                      Space.height(MySize.getHeight(20)),
                                      (controller.hasData.isFalse)
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                  color: appTheme.primaryTheme),
                                            )
                                          : (!isNullEmptyOrFalse(controller
                                                      .procedureDetailsList) ||
                                                  !isNullEmptyOrFalse(controller
                                                      .addedPatientProcedureDetailsList))
                                              ? GridView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          MySize.getWidth(15)),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisSpacing:
                                                          MySize.getWidth(10),
                                                      mainAxisSpacing:
                                                          MySize.getHeight(15),
                                                      childAspectRatio:
                                                          MySize.getHeight(
                                                              1.35),
                                                      crossAxisCount: 2),
                                                  itemCount: (controller
                                                          .isAddedPatients
                                                          .isTrue)
                                                      ? controller
                                                          .addedPatientProcedureDetailsList
                                                          .length
                                                      : controller
                                                          .procedureDetailsList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index == 0) {
                                                      return Showcase(
                                                        description:
                                                            "Final review how this will be used for all the patients added to this procedure",
                                                        onTargetClick: () {
                                                          controller
                                                              .scrollController
                                                              .jumpTo(controller
                                                                  .scrollController
                                                                  .position
                                                                  .maxScrollExtent);
                                                          ShowCaseWidget.of(
                                                                  context)
                                                              .dispose();
                                                        },
                                                        disposeOnTap: true,
                                                        key: controller
                                                            .reviewShowCaseKey
                                                            .value,
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
                                                        child: Container(
                                                          child: Neumorphic(
                                                            style:
                                                                NeumorphicStyle(
                                                              depth: -10,
                                                              shadowLightColorEmboss:
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.8),
                                                              shadowDarkColorEmboss:
                                                                  Color(0xff000000)
                                                                      .withOpacity(
                                                                          0.4),
                                                              color: appTheme
                                                                  .backgroundTheme,
                                                              boxShape: NeumorphicBoxShape
                                                                  .roundRect(BorderRadius
                                                                      .circular(
                                                                          MySize.getHeight(
                                                                              10))),
                                                            ),
                                                            child: Container(
                                                              height: MySize
                                                                  .getHeight(
                                                                      118),
                                                              width: MySize
                                                                  .getWidth(
                                                                      160),
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: MySize
                                                                      .getWidth(
                                                                          14),
                                                                  vertical: MySize
                                                                      .getHeight(
                                                                          10)),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Day ${(controller.isAddedPatients.isTrue) ? (controller.addedPatientProcedureDetailsList[index].day).toString().padLeft(2, '0') : (controller.procedureDetailsList[index].day).toString().padLeft(2, '0')}",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xffBD6A8D),
                                                                          fontSize: MySize.getHeight(
                                                                              15),
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            MySize.getHeight(10)),
                                                                    if (controller
                                                                        .isAddedPatients
                                                                        .isFalse)
                                                                      if (!isNullEmptyOrFalse(controller
                                                                          .procedureDetailsList[
                                                                              index]
                                                                          .events))
                                                                        Column(
                                                                          children: List.generate(
                                                                              controller.procedureDetailsList[index].events!.length,
                                                                              (index2) => Padding(
                                                                                    padding: EdgeInsets.only(bottom: MySize.getHeight(5)),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          height: MySize.getHeight(20),
                                                                                          width: MySize.getWidth(20),
                                                                                          child: SvgPicture.asset(
                                                                                            controller.procedureDetailsList[index].events![index2].image.toString(),
                                                                                            height: MySize.getHeight(20),
                                                                                            width: MySize.getWidth(20),
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        ),
                                                                                        Space.width(MySize.getWidth(10)),
                                                                                        Text(controller.procedureDetailsList[index].events![index2].eventName.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                        ),
                                                                    if (controller
                                                                        .isAddedPatients
                                                                        .isTrue)
                                                                      if (!isNullEmptyOrFalse(controller
                                                                          .addedPatientProcedureDetailsList[
                                                                              index]
                                                                          .events))
                                                                        Column(
                                                                          children: List.generate(
                                                                              controller.addedPatientProcedureDetailsList[index].events!.length,
                                                                              (index2) => Row(
                                                                                    children: [
                                                                                      SvgPicture.asset(
                                                                                        controller.addedPatientProcedureDetailsList[index].events![index2].image.toString(),
                                                                                        height: MySize.getHeight(20),
                                                                                        width: MySize.getWidth(20),
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                      Space.width(MySize.getWidth(10)),
                                                                                      Text(controller.addedPatientProcedureDetailsList[index].events![index2].eventName.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                                                                    ],
                                                                                  )),
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                      child: Neumorphic(
                                                        style: NeumorphicStyle(
                                                          depth: -10,
                                                          shadowLightColorEmboss:
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.8),
                                                          shadowDarkColorEmboss:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.4),
                                                          color: appTheme
                                                              .backgroundTheme,
                                                          boxShape: NeumorphicBoxShape
                                                              .roundRect(BorderRadius
                                                                  .circular(MySize
                                                                      .getHeight(
                                                                          10))),
                                                        ),
                                                        child: Container(
                                                          height:
                                                              MySize.getHeight(
                                                                  118),
                                                          width:
                                                              MySize.getWidth(
                                                                  160),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: MySize
                                                                      .getWidth(
                                                                          14),
                                                                  vertical: MySize
                                                                      .getHeight(
                                                                          10)),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Day ${(controller.isAddedPatients.isTrue) ? (controller.addedPatientProcedureDetailsList[index].day).toString().padLeft(2, '0') : (controller.procedureDetailsList[index].day).toString().padLeft(2, '0')}",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffBD6A8D),
                                                                      fontSize:
                                                                          MySize.getHeight(
                                                                              15),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                    height: MySize
                                                                        .getHeight(
                                                                            10)),
                                                                if (controller
                                                                    .isAddedPatients
                                                                    .isFalse)
                                                                  if (!isNullEmptyOrFalse(controller
                                                                      .procedureDetailsList[
                                                                          index]
                                                                      .events))
                                                                    Column(
                                                                      children: List.generate(
                                                                          controller.procedureDetailsList[index].events!.length,
                                                                          (index2) => Padding(
                                                                                padding: EdgeInsets.only(bottom: MySize.getHeight(5)),
                                                                                child: Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: MySize.getHeight(20),
                                                                                      width: MySize.getWidth(20),
                                                                                      child: SvgPicture.asset(
                                                                                        controller.procedureDetailsList[index].events![index2].image.toString(),
                                                                                        height: MySize.getHeight(20),
                                                                                        width: MySize.getWidth(20),
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                    ),
                                                                                    Space.width(MySize.getWidth(10)),
                                                                                    Text(controller.procedureDetailsList[index].events![index2].eventName.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                    ),
                                                                if (controller
                                                                    .isAddedPatients
                                                                    .isTrue)
                                                                  if (!isNullEmptyOrFalse(controller
                                                                      .addedPatientProcedureDetailsList[
                                                                          index]
                                                                      .events))
                                                                    Column(
                                                                      children: List.generate(
                                                                          controller.addedPatientProcedureDetailsList[index].events!.length,
                                                                          (index2) => Row(
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    controller.addedPatientProcedureDetailsList[index].events![index2].image.toString(),
                                                                                    height: MySize.getHeight(20),
                                                                                    width: MySize.getWidth(20),
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                  Space.width(MySize.getWidth(10)),
                                                                                  Text(controller.addedPatientProcedureDetailsList[index].events![index2].eventName.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                                                                ],
                                                                              )),
                                                                    ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })
                                              : SizedBox(),
                                      Space.height(MySize.getHeight(5)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (controller
                                      .isWholeProcedureReview.isTrue) {
                                    if (controller.isTourStarted.isTrue) {
                                      box.write(
                                          ArgumentConstant.tourStep1Started,
                                          false);
                                      box.write(
                                          ArgumentConstant.tourStep1Completed,
                                          true);
                                    }
                                    if (controller.isAddedPatients.isTrue) {
                                      controller.callPatientProcedureAssignment(
                                          context: context);
                                    } else if (controller.isProcedureView) {
                                      controller.procuduresController
                                          .callProceduresListingApi(
                                              context: context);
                                      controller
                                          .procuduresController
                                          .isRecentlyAddedOrEditedProcedureDbId
                                          .value = controller.procedureDbId;
                                      controller.procuduresController
                                          .isProcedureViewed.value = false;
                                      Get.back();
                                      Get.back();
                                    } else {
                                      controller.callUpdateProcedure(
                                          context: context);
                                    }
                                  } else {
                                    getGetXSnackBar(
                                        title: "Error",
                                        msg:
                                            "Please review whole procedure first.");
                                  }
                                },
                                child: Container(
                                  width: MySize.getWidth(332),
                                  height: MySize.getHeight(56),
                                  margin: EdgeInsets.only(
                                      bottom: MySize.getHeight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MySize.getHeight(15)),
                                    color: (controller
                                            .isWholeProcedureReview.isTrue)
                                        ? appTheme.primaryTheme
                                        : appTheme.primaryTheme
                                            .withOpacity(0.6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    (controller.isAddedPatients.isTrue)
                                        ? "Next"
                                        : "Save Procedure",
                                    style: TextStyle(
                                        color: (controller
                                                .isWholeProcedureReview.isTrue)
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        fontSize: MySize.getHeight(18)),
                                  ),
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
}
