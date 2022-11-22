import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../constants/sizeConstant.dart';
import '../controllers/create_procedure_define_controller.dart';

class CreateProcedureDefineView
    extends GetWidget<CreateProcedureDefineController> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onFinish: () {
        controller.tourViewed.value = true;
        controller.tourViewed.refresh();
      },
      disableBarrierInteraction: true,
      builder: Builder(builder: (context) {
        if (controller.isTourStarted.value && controller.tourViewed.isFalse) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Future.delayed(Duration(milliseconds: 400), () {
              ShowCaseWidget.of(context)
                  .startShowCase([controller.procedureNameShowCaseKey.value]);
            }),
          );
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.red50,
            body: Obx(() {
              return (controller.hasData.isFalse)
                  ? Center(
                      child: CircularProgressIndicator(
                          color: appTheme.primaryTheme))
                  : Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.red50,
                        border: Border.all(
                          color: ColorConstant.black90033,
                          width: MySize.getWidth(0.50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
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
                                              color:
                                                  Colors.black.withOpacity(0.1))
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                MySize.getHeight(50)),
                                            bottomRight: Radius.circular(
                                                MySize.getHeight(50)))),
                                    child: Column(
                                      children: [
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
                                                width: MySize.getWidth(21)),
                                            Text(
                                              "Create Procedure",
                                              style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(18),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Spacer(),
                                            SvgPicture.asset(
                                                "assets/egg_pic02.svg"),
                                          ],
                                        ),
                                        SizedBox(height: MySize.getHeight(10)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MySize.getWidth(40)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Define",
                                                  style: TextStyle(
                                                      color:
                                                          appTheme.primaryTheme,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          MySize.getHeight(14)),
                                                ),
                                                Text(
                                                  "Customise",
                                                  style: TextStyle(
                                                      color: Color(0xffBD6A8D),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          MySize.getHeight(14)),
                                                ),
                                                Text(
                                                  "Review",
                                                  style: TextStyle(
                                                      color: Color(0xffBD6A8D),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          MySize.getHeight(14)),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(height: MySize.getHeight(16)),
                                        Image(
                                          image:
                                              AssetImage("assets/Track01.png"),
                                          width: MySize.getWidth(281),
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: MySize.getHeight(25)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MySize.getWidth(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select Procedure Type",
                                          style: TextStyle(
                                              fontSize: MySize.getHeight(14),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: MySize.getHeight(10)),
                                        Row(
                                            children: List.generate(
                                                controller.procedureTypeList
                                                    .length, (index) {
                                          return InkWell(
                                            onTap: () {
                                              // controller.procedureTypeList.forEach((element) {
                                              //   element.isActive!.value = false;
                                              // });
                                              // if (controller.procedureTypeList[index].title ==
                                              //     "Egg Donor") {
                                              //   controller.procedureTypeList[index].isActive!
                                              //       .value = true;
                                              // }
                                              // controller.selectedProcedureName.value =
                                              //     controller.procedureTypeList[index].title!;
                                            },
                                            child: Row(
                                              children: [
                                                Neumorphic(
                                                  style: (controller
                                                          .procedureTypeList[
                                                              index]
                                                          .isActive!
                                                          .value)
                                                      ? NeumorphicStyle(
                                                          color: ColorConstant
                                                              .red50,
                                                          depth: (controller
                                                                  .procedureTypeList[
                                                                      index]
                                                                  .isActive!
                                                                  .value)
                                                              ? -10
                                                              : 0,
                                                          shadowLightColorEmboss:
                                                              Colors.white)
                                                      : null,
                                                  child: Container(
                                                    height:
                                                        MySize.getHeight(72),
                                                    width: MySize.getWidth(97),
                                                    decoration: (controller
                                                            .procedureTypeList[
                                                                index]
                                                            .isActive!
                                                            .value)
                                                        ? null
                                                        : BoxDecoration(
                                                            color: ColorConstant
                                                                .red50,
                                                            boxShadow: appTheme
                                                                .getShadow,
                                                            borderRadius: BorderRadius
                                                                .circular(MySize
                                                                    .getHeight(
                                                                        10))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .procedureTypeList[
                                                                  index]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      13.5),
                                                              color: (controller
                                                                      .procedureTypeList[
                                                                          index]
                                                                      .isActive!
                                                                      .value)
                                                                  ? appTheme
                                                                      .primaryTheme
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                            height: MySize
                                                                .getHeight(4)),
                                                        Text(
                                                          controller
                                                              .procedureTypeList[
                                                                  index]
                                                              .subTitle
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      12),
                                                              color: (controller
                                                                      .procedureTypeList[
                                                                          index]
                                                                      .isActive!
                                                                      .value)
                                                                  ? Colors.black
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                        if (!controller
                                                            .procedureTypeList[
                                                                index]
                                                            .isActive!
                                                            .value)
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: MySize
                                                                        .getHeight(
                                                                            5)),
                                                            child: Text(
                                                              "Coming Soon",
                                                              style: TextStyle(
                                                                  fontSize: MySize
                                                                      .getHeight(
                                                                          10),
                                                                  color: Color(
                                                                          0xffFD7E5C)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                if (index !=
                                                    controller.procedureTypeList
                                                            .length -
                                                        1)
                                                  SizedBox(
                                                      width:
                                                          MySize.getWidth(13)),
                                              ],
                                            ),
                                          );
                                        })),
                                        SizedBox(height: MySize.getHeight(30)),
                                        Text(
                                          "Procedure Name",
                                          style: TextStyle(
                                              fontSize: MySize.getHeight(14),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: MySize.getHeight(4)),
                                        Showcase(
                                          key: controller
                                              .procedureNameShowCaseKey.value,
                                          description:
                                              "Give a name to your procedure",
                                          onTargetClick: () {
                                            print("Clicked");
                                            controller.tourViewed.value = true;
                                            controller.tourViewed.refresh();
                                            FocusScope.of(context).unfocus();
                                            controller.textFieldFocusNode
                                                .requestFocus();
                                          },
                                          onToolTipClick: () {
                                            controller.tourViewed.value = true;
                                            controller.tourViewed.refresh();
                                            FocusScope.of(context).unfocus();
                                            controller.textFieldFocusNode
                                                .requestFocus();
                                          },
                                          disposeOnTap: true,
                                          overlayPadding: EdgeInsets.symmetric(
                                              vertical: MySize.getHeight(10),
                                              horizontal: MySize.getWidth(10)),
                                          overlayColor: Colors.transparent,
                                          overlayOpacity: 0.2,
                                          showcaseBackgroundColor: Colors.white,
                                          child: getTextField(
                                            focusNode:
                                                controller.textFieldFocusNode,
                                            textEditingController: controller
                                                .procedureNameController,
                                            onChange: (val) {
                                              if (!isNullEmptyOrFalse(val)) {
                                                controller.isButtonEnable
                                                    .value = true;
                                                controller.errorText.value = "";
                                              } else {
                                                controller.isButtonEnable
                                                    .value = false;
                                              }
                                            },
                                            hintText: "IVF-Egg Donor - A|",
                                            errorText:
                                                controller.errorText.value,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (controller.isButtonEnable.isTrue) {
                                FocusScope.of(context).unfocus();
                                if (!isNullEmptyOrFalse(controller
                                    .procedureNameController.text
                                    .trim())) {
                                  controller.procedureTypeList
                                      .forEach((element) {
                                    if (element.isActive!.value == true) {
                                      controller.createNewProcedureApi(
                                          context: context,
                                          procedureTypeModel: element);
                                    }
                                  });
                                }
                              } else {
                                controller.errorText.value =
                                    "Please enter procedure name.";
                              }
                            },
                            child: Container(
                              width: MySize.getWidth(332),
                              height: MySize.getHeight(56),
                              margin: EdgeInsets.symmetric(
                                  horizontal: MySize.getWidth(14),
                                  vertical: MySize.getHeight(14)),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(MySize.getHeight(15)),
                                color: (controller.isButtonEnable.isTrue)
                                    ? appTheme.primaryTheme
                                    : appTheme.primaryTheme.withOpacity(0.6),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: (controller.isButtonEnable.isTrue)
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    fontSize: MySize.getHeight(18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
            // bottomSheet: Container(
            //   color: ColorConstant.red50,
            //   child: InkWell(
            //     onTap: () {
            //       FocusScope.of(context).unfocus();
            //       if (!isNullEmptyOrFalse(
            //           controller.procedureNameController.text.trim())) {
            //         controller.procedureTypeList.forEach((element) {
            //           if (element.isActive!.value == true) {
            //             controller.createNewProcedureApi(
            //                 context: context, procedureTypeModel: element);
            //           }
            //         });
            //       } else {
            //         getSnackBar(
            //             context: context, text: "Please enter procedure name.");
            //       }
            //     },
            //     child: Container(
            //       width: MySize.getWidth(332),
            //       height: MySize.getHeight(56),
            //       margin: EdgeInsets.symmetric(
            //           horizontal: MySize.getWidth(14),
            //           vertical: MySize.getHeight(14)),
            //       decoration: BoxDecoration(
            //         borderRadius:
            //             BorderRadius.circular(MySize.getHeight(15)),
            //         color: appTheme.primaryTheme,
            //       ),
            //       alignment: Alignment.center,
            //       child: Text(
            //         "Next",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: MySize.getHeight(18)),
            //       ),
            //     ),
            //   ),
            // ),
          ),
        );
      }),
    );
  }
}

class ProcedureTypeModel {
  String? id;
  String? title;
  String? subTitle;
  RxBool? isActive;

  ProcedureTypeModel(
      {required this.id,
      required this.isActive,
      required this.title,
      required this.subTitle});
}
