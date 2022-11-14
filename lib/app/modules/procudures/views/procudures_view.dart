import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/theme/app_style.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../create_procedure_customise/views/create_procedure_customise_view.dart';
import '../controllers/procudures_controller.dart';

class ProcuduresView extends StatefulWidget {
  const ProcuduresView({Key? key}) : super(key: key);
  @override
  State<ProcuduresView> createState() => _ProcedureViewState();
}

class _ProcedureViewState extends State<ProcuduresView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcuduresController>(
        init: ProcuduresController(),
        builder: (controller) {
          return ShowCaseWidget(
              onFinish: () {
                controller.tourViewed.value = true;
                controller.tourViewed.refresh();
              },
              disableBarrierInteraction: true,
              builder: Builder(
                builder: (context) {
                  if (controller.isTourStarted.value &&
                      controller.tourViewed.isFalse &&
                      controller.hasData.isTrue) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Future.delayed(Duration(milliseconds: 300), () {
                        ShowCaseWidget.of(context).startShowCase(
                            [controller.eggDonorShowCaseKey.value]);
                      }),
                    );
                  }
                  if (box.read(ArgumentConstant.tourStep1Completed)) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Future.delayed(Duration(milliseconds: 0), () {
                        ShowCaseWidget.of(context).startShowCase(
                            [controller.completeProcedureShowCaseKey.value]);
                      }),
                    );
                  }

                  return Scaffold(
                    body: Obx(() {
                      if (!box.read(ArgumentConstant.tourStep1Completed)) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          if (controller.isTourStarted.value &&
                              controller.isDownDone.isFalse &&
                              controller.hasData.isTrue) {
                            controller.scrollController.jumpTo(controller
                                .scrollController.position.maxScrollExtent);
                            controller.isDownDone.value = true;
                            controller.refresh();
                            controller.update();
                          }
                        });
                      }

                      return Container(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                                                    "Procedures",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textStyleDMSansmedium16
                                                        .copyWith(
                                                      fontSize:
                                                          MySize.getHeight(16),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                            //               blurRadius: MySize.size2!,
                                            //               spreadRadius: MySize.size2!,
                                            //             ),
                                            //             BoxShadow(
                                            //               offset: Offset(-1, -1),
                                            //               color: Colors.white,
                                            //               blurRadius: MySize.size2!,
                                            //               spreadRadius: MySize.size2!,
                                            //             ),
                                            //           ],
                                            //           borderRadius:
                                            //               BorderRadius.circular(2000),
                                            //           color: appTheme.shadowColor),
                                            //       // child:
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
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize.getWidth(19)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: MySize.getHeight(24)),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PROCEDURES CREATED",
                                              style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(12),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(15)),
                                            (controller.hasData.isFalse)
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: appTheme
                                                                .primaryTheme),
                                                  )
                                                : (!isNullEmptyOrFalse(
                                                        controller.procedures))
                                                    ? ScrollablePositionedList
                                                        .builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                controller
                                                                    .procedures
                                                                    .length,
                                                            itemScrollController:
                                                                controller
                                                                    .itemScrollController,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              if (!box.read(
                                                                  ArgumentConstant
                                                                      .tourStep1Completed)) {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback(
                                                                        (timeStamp) {
                                                                  if (controller
                                                                      .isProcedureViewed
                                                                      .isFalse) {
                                                                    controller
                                                                        .procedures
                                                                        .forEach(
                                                                            (element) {
                                                                      if (element
                                                                              .id ==
                                                                          controller
                                                                              .isRecentlyAddedOrEditedProcedureDbId
                                                                              .value) {
                                                                        controller.itemScrollController.scrollTo(
                                                                            index:
                                                                                controller.procedures.indexOf(element),
                                                                            duration: Duration(milliseconds: 200));
                                                                      }
                                                                    });
                                                                    controller
                                                                        .isProcedureViewed
                                                                        .value = true;
                                                                  }
                                                                });
                                                              }
                                                              if (box.read(
                                                                  ArgumentConstant
                                                                      .tourStep1Completed)) {
                                                                if (controller
                                                                        .isRecentlyAddedOrEditedProcedureDbId
                                                                        .value ==
                                                                    controller
                                                                        .procedures[
                                                                            index]
                                                                        .id!) {
                                                                  return Showcase
                                                                      .withWidget(
                                                                    key: controller
                                                                        .completeProcedureShowCaseKey
                                                                        .value,
                                                                    height: MySize
                                                                        .getHeight(
                                                                            40),
                                                                    width: MySize
                                                                        .getWidth(
                                                                            200),
                                                                    onTargetClick:
                                                                        () {
                                                                      ShowCaseWidget.of(
                                                                              context)
                                                                          .next();
                                                                      controller.updateTourStepApi(
                                                                          context:
                                                                              context);
                                                                    },
                                                                    container:
                                                                        Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left:
                                                                              MySize.getWidth(20),
                                                                          child:
                                                                              CustomPaint(
                                                                            painter:
                                                                                Arrow(
                                                                              strokeColor: Colors.white,
                                                                              strokeWidth: 10,
                                                                              paintingStyle: PaintingStyle.fill,
                                                                              isUpArrow: true,
                                                                            ),
                                                                            child:
                                                                                SizedBox(
                                                                              height: MySize.getHeight(9),
                                                                              width: MySize.getWidth(18),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: MySize.getHeight(9)),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: MySize.getWidth(20),
                                                                              vertical: MySize.getHeight(5)),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(MySize.getHeight(10))),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(width: MySize.getWidth(270), child: Text("Congratulations. You have created your first IVF Procedure.")),
                                                                              Spacing.height(5),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  ShowCaseWidget.of(context).next();
                                                                                  controller.updateTourStepApi(context: context);
                                                                                },
                                                                                child: Text(
                                                                                  "GO BACK TO HOME",
                                                                                  style: TextStyle(color: appTheme.primaryTheme),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    overlayPadding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            MySize.getHeight(
                                                                                10),
                                                                        horizontal:
                                                                            MySize.getWidth(10)),
                                                                    overlayColor:
                                                                        Colors
                                                                            .transparent,
                                                                    overlayOpacity:
                                                                        0.2,
                                                                    showcaseBackgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    child: Card(
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          MySize.getHeight(
                                                                              10),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            MySize.getHeight(56),
                                                                        width: MySize.getWidth(
                                                                            327),
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: MySize.getWidth(15)),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: (controller.isRecentlyAddedOrEditedProcedureDbId.value == controller.procedures[index].id!)
                                                                              ? appTheme.primaryTheme.withOpacity(0.3)
                                                                              : Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            MySize.getHeight(10),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  controller.procedures[index].name!,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              }

                                                              return InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .isRecentlyAddedOrEditedProcedureDbId
                                                                          .value =
                                                                      controller
                                                                          .procedures[
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                  controller
                                                                      .isRecentlyAddedOrEditedProcedureDbId
                                                                      .refresh();
                                                                  Get.toNamed(
                                                                      Routes
                                                                          .CREATE_PROCEDURE_CUSTOMISE,
                                                                      arguments: {
                                                                        ArgumentConstant.procedureDbId: controller
                                                                            .procedures[index]
                                                                            .id,
                                                                        ArgumentConstant.isProcedureView:
                                                                            true,
                                                                      });
                                                                  print(controller
                                                                      .procedures[
                                                                          index]
                                                                      .id);
                                                                },
                                                                onLongPress:
                                                                    () {
                                                                  controller.deleteProcedureApi(
                                                                      context:
                                                                          context,
                                                                      id: controller
                                                                          .procedures[
                                                                              index]
                                                                          .id!);
                                                                },
                                                                child: getCard(
                                                                    context:
                                                                        context,
                                                                    index:
                                                                        index,
                                                                    controller:
                                                                        controller),
                                                              );
                                                            })
                                                    : Text(
                                                        "NO PROCEDURES CREATED YET",
                                                        style: TextStyle(
                                                            fontSize: MySize
                                                                .getHeight(12),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                            SizedBox(
                                                height: MySize.getHeight(24)),
                                            Text(
                                              "CUSTOMISE YOUR PROCEDURE000",
                                              style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(12),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(24)),
                                            Row(
                                              children: [
                                                if (!box.read(ArgumentConstant
                                                    .tourStep1Completed))
                                                  Showcase(
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
                                                      key: controller
                                                          .eggDonorShowCaseKey
                                                          .value,
                                                      overlayOpacity: 0.2,
                                                      description:
                                                          "These are the templates to create your clinic procedures",
                                                      disposeOnTap: true,
                                                      onTargetClick: () {
                                                        if (mounted) {
                                                          controller.tourViewed
                                                              .value = true;
                                                          controller.tourViewed
                                                              .refresh();
                                                        }

                                                        Get.toNamed(Routes
                                                            .CREATE_PROCEDURE_DEFINE);
                                                      },
                                                      onToolTipClick: () {
                                                        if (mounted) {
                                                          controller.tourViewed
                                                              .value = true;
                                                          controller.tourViewed
                                                              .refresh();
                                                        }

                                                        Get.toNamed(Routes
                                                            .CREATE_PROCEDURE_DEFINE);
                                                      },
                                                      child: getContainer(
                                                          isEnable: true))
                                                else
                                                  getContainer(isEnable: true),
                                                SizedBox(
                                                    width: MySize.getWidth(12)),
                                                getContainer(
                                                  image:
                                                      "assets/post_embryo_pic.svg",
                                                  text: "Pre Embryo",
                                                  text2: "14-18 days",
                                                  text3: "Comingsoon",
                                                ),
                                                SizedBox(
                                                    width: MySize.getWidth(12)),
                                                getContainer(
                                                  image:
                                                      "assets/pre_embryo_pic.svg",
                                                  text: "Post Embryo",
                                                  text2: "14-18 days",
                                                  text3: "Comingsoon",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(5)),
                                          ],
                                        ),
                                      ),
                                      Spacing.height(60),
                                    ],
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

  Widget getCard(
      {required BuildContext context,
      required int index,
      required ProcuduresController controller}) {
    return Obx(() {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MySize.getHeight(10),
          ),
        ),
        child: Container(
          height: MySize.getHeight(56),
          width: MySize.getWidth(327),
          padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(15)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (controller.isRecentlyAddedOrEditedProcedureDbId.value ==
                    controller.procedures[index].id!)
                ? appTheme.primaryTheme.withOpacity(0.3)
                : Colors.white,
            borderRadius: BorderRadius.circular(
              MySize.getHeight(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    controller.procedures[index].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget getContainer(
      {String image = "assets/egg_pic01.svg",
      String text = "Egg Donor",
      String text2 = "14-18 days",
      String text3 = "Create",
      bool isEnable = false}) {
    return InkWell(
      onTap: () {
        if (text == "Egg Donor") {
          Get.toNamed(Routes.CREATE_PROCEDURE_DEFINE);
        }
      },
      child: Container(
        height: MySize.getHeight(151),
        width: MySize.getWidth(98),
        decoration: BoxDecoration(
          color: (isEnable)
              ? ColorConstant.red50
              : ColorConstant.red50.withOpacity(0.5),
          borderRadius: BorderRadius.circular(MySize.getHeight(15)),
          boxShadow: appTheme.getShadow,
        ),
        child: Column(
          children: [
            SizedBox(height: MySize.getHeight(28)),
            SvgPicture.asset(
              image,
            ),
            SizedBox(height: MySize.getHeight(9)),
            Text(
              text,
              style: TextStyle(
                  fontSize: MySize.getHeight(13.5),
                  color:
                      (isEnable) ? Colors.black : Colors.black.withOpacity(0.4),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MySize.getHeight(3)),
            Text(
              text2,
              style: TextStyle(
                  fontSize: MySize.getHeight(12),
                  color:
                      (isEnable) ? Colors.black : Colors.black.withOpacity(0.4),
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: MySize.getHeight(9)),
            Text(
              text3,
              style: TextStyle(
                  fontSize: MySize.getHeight(11),
                  color: (isEnable)
                      ? Color(0xffFD7E5C)
                      : Color(0xffFD7E5C).withOpacity(0.3),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class ProcuduresView2 extends GetWidget<ProcuduresController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProcuduresController>(
//         init: ProcuduresController(),
//         builder: (controller) {
//           return ShowCaseWidget(onFinish: () {
//             controller.tourViewed.value = true;
//             controller.tourViewed.refresh();
//           }, onComplete: (int, key) {
//             print("==-->");
//             print(key.currentState);
//             print(int);
//             print("<---==--");
//           }, builder: Builder(
//             builder: (context) {
//               if (controller.isTourStarted.value &&
//                   controller.tourViewed.isFalse) {
//                 WidgetsBinding.instance.addPostFrameCallback(
//                   (_) => Future.delayed(Duration(milliseconds: 0), () {
//                     ShowCaseWidget.of(context)
//                         .startShowCase([controller.eggDonorShowCaseKey.value]);
//                   }),
//                 );
//               }
//               if (box.read(ArgumentConstant.tourStep1Completed)) {
//                 // WidgetsBinding.instance.addPostFrameCallback(
//                 //   (_) => Future.delayed(Duration(milliseconds: 0), () {
//                 //     ShowCaseWidget.of(context).startShowCase(
//                 //         [controller.completeProcedureShowCaseKey.value]);
//                 //   }),
//                 // );
//               }
//
//               return Scaffold(
//                 body: Obx(() {
//                   if (!box.read(ArgumentConstant.tourStep1Completed)) {
//                     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                       if (controller.isTourStarted.value &&
//                           controller.isDownDone.isFalse &&
//                           controller.hasData.isTrue) {
//                         controller.scrollController.jumpTo(controller
//                             .scrollController.position.maxScrollExtent);
//                         controller.isDownDone.value = true;
//                         controller.refresh();
//                         controller.update();
//                       }
//                     });
//                   }
//
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: ColorConstant.red50,
//                       border: Border.all(
//                         color: ColorConstant.black90033,
//                         width: MySize.getWidth(0.50),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           height: MySize.getHeight(90),
//                           decoration: BoxDecoration(
//                             color: ColorConstant.pink50A2,
//                           ),
//                           child: Column(
//                             // mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   width: MySize.screenWidth,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                       left: MySize.getWidth(8),
//                                       right: MySize.getWidth(11),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       // mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Image.asset(
//                                               "assets/splash_01_01.png",
//                                               height: MySize.getHeight(40),
//                                               width: MySize.getWidth(40),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                 left: MySize.getWidth(12),
//                                                 bottom: MySize.getHeight(0),
//                                               ),
//                                               child: Text(
//                                                 "Procedures",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.left,
//                                                 style: AppStyle
//                                                     .textStyleDMSansmedium16
//                                                     .copyWith(
//                                                   fontSize:
//                                                       MySize.getHeight(16),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         // Stack(
//                                         //   alignment: Alignment.center,
//                                         //   children: [
//                                         //     Container(
//                                         //       height: MySize.getHeight(36),
//                                         //       width: MySize.getWidth(36),
//                                         //       decoration: BoxDecoration(
//                                         //           boxShadow: [
//                                         //             BoxShadow(
//                                         //               offset: Offset(2, 2),
//                                         //               color: Colors.black26,
//                                         //               blurRadius: MySize.size2!,
//                                         //               spreadRadius: MySize.size2!,
//                                         //             ),
//                                         //             BoxShadow(
//                                         //               offset: Offset(-1, -1),
//                                         //               color: Colors.white,
//                                         //               blurRadius: MySize.size2!,
//                                         //               spreadRadius: MySize.size2!,
//                                         //             ),
//                                         //           ],
//                                         //           borderRadius:
//                                         //               BorderRadius.circular(2000),
//                                         //           color: appTheme.shadowColor),
//                                         //       // child:
//                                         //     ),
//                                         //     SvgPicture.asset(
//                                         //       "assets/noti_01.svg",
//                                         //       fit: BoxFit.cover,
//                                         //       height: MySize.getHeight(55),
//                                         //       width: MySize.getWidth(55),
//                                         //     ),
//                                         //   ],
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             controller: controller.scrollController,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: MySize.getWidth(19)),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: MySize.getHeight(24)),
//                                   Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "PROCEDURES CREATED",
//                                           style: TextStyle(
//                                               fontSize: MySize.getHeight(12),
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         SizedBox(height: MySize.getHeight(15)),
//                                         (controller.hasData.isFalse)
//                                             ? Center(
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                         color: appTheme
//                                                             .primaryTheme),
//                                               )
//                                             : (!isNullEmptyOrFalse(
//                                                     controller.procedures))
//                                                 ? ()?:ScrollablePositionedList
//                                                     .builder(
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         itemCount: controller
//                                                             .procedures.length,
//                                                         itemScrollController:
//                                                             controller
//                                                                 .itemScrollController,
//                                                         scrollDirection:
//                                                             Axis.vertical,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           print(
//                                                               "My Boxes Value : =  ${box.read(ArgumentConstant.tourStep1Completed)}");
//                                                           if (!box.read(
//                                                               ArgumentConstant
//                                                                   .tourStep1Completed)) {
//                                                             print(
//                                                                 "My Boxes Value 2323232: =  ${box.read(ArgumentConstant.tourStep1Completed)}");
//                                                             // WidgetsBinding
//                                                             //     .instance
//                                                             //     .addPostFrameCallback(
//                                                             //         (timeStamp) {
//                                                             //   if (controller
//                                                             //       .isProcedureViewed
//                                                             //       .isFalse) {
//                                                             //     controller
//                                                             //         .procedures
//                                                             //         .forEach(
//                                                             //             (element) {
//                                                             //       if (element
//                                                             //               .id ==
//                                                             //           controller
//                                                             //               .isRecentlyAddedOrEditedProcedureDbId
//                                                             //               .value) {
//                                                             //         controller.itemScrollController.scrollTo(
//                                                             //             index: controller
//                                                             //                 .procedures
//                                                             //                 .indexOf(
//                                                             //                     element),
//                                                             //             duration:
//                                                             //                 Duration(milliseconds: 200));
//                                                             //       }
//                                                             //     });
//                                                             //     controller
//                                                             //         .isProcedureViewed
//                                                             //         .value = true;
//                                                             //   }
//                                                             // });
//                                                           }
//                                                           return InkWell(
//                                                             onTap: () {
//                                                               controller
//                                                                       .isRecentlyAddedOrEditedProcedureDbId
//                                                                       .value =
//                                                                   controller
//                                                                       .procedures[
//                                                                           index]
//                                                                       .id
//                                                                       .toString();
//                                                               controller
//                                                                   .isRecentlyAddedOrEditedProcedureDbId
//                                                                   .refresh();
//                                                               Get.toNamed(
//                                                                   Routes
//                                                                       .CREATE_PROCEDURE_CUSTOMISE,
//                                                                   arguments: {
//                                                                     ArgumentConstant
//                                                                             .procedureDbId:
//                                                                         controller
//                                                                             .procedures[index]
//                                                                             .id,
//                                                                     ArgumentConstant
//                                                                             .isProcedureView:
//                                                                         true,
//                                                                   });
//                                                               print(controller
//                                                                   .procedures[
//                                                                       index]
//                                                                   .id);
//                                                             },
//                                                             onLongPress: () {
//                                                               controller.deleteProcedureApi(
//                                                                   context:
//                                                                       context,
//                                                                   id: controller
//                                                                       .procedures[
//                                                                           index]
//                                                                       .id!);
//                                                             },
//                                                             child: getCard(
//                                                                 context:
//                                                                     context,
//                                                                 index: index,
//                                                                 controller:
//                                                                     controller),
//                                                           );
//                                                         })
//                                                 : Text(
//                                                     "NO PROCEDURES CREATED YET",
//                                                     style: TextStyle(
//                                                         fontSize:
//                                                             MySize.getHeight(
//                                                                 12),
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                                   ),
//                                         SizedBox(height: MySize.getHeight(24)),
//                                         Text(
//                                           "CUSTOMISE YOUR PROCEDURE",
//                                           style: TextStyle(
//                                               fontSize: MySize.getHeight(12),
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(height: MySize.getHeight(24)),
//                                         Row(
//                                           children: [
//                                             if (!box.read(ArgumentConstant
//                                                 .tourStep1Completed))
//                                               Showcase(
//                                                   overlayPadding:
//                                                       EdgeInsets.symmetric(
//                                                           vertical:
//                                                               MySize.getHeight(
//                                                                   10),
//                                                           horizontal:
//                                                               MySize.getWidth(
//                                                                   10)),
//                                                   overlayColor:
//                                                       Colors.transparent,
//                                                   key: controller
//                                                       .eggDonorShowCaseKey
//                                                       .value,
//                                                   overlayOpacity: 0.2,
//                                                   description:
//                                                       "These are the templates to create your clinic procedures",
//                                                   disposeOnTap: true,
//                                                   onTargetClick: () {
//                                                     if(mounted){
//
//                                                     }
//                                                     controller.tourViewed
//                                                         .value = true;
//                                                     controller.tourViewed
//                                                         .refresh();
//
//                                                     Get.toNamed(Routes
//                                                         .CREATE_PROCEDURE_DEFINE);
//                                                   },
//                                                   child: getContainer(
//                                                       isEnable: true))
//                                             else
//                                               getContainer(isEnable: true),
//                                             SizedBox(
//                                                 width: MySize.getWidth(12)),
//                                             getContainer(
//                                               image:
//                                                   "assets/post_embryo_pic.svg",
//                                               text: "Pre Embryo",
//                                               text2: "14-18 days",
//                                               text3: "Comingsoon",
//                                             ),
//                                             SizedBox(
//                                                 width: MySize.getWidth(12)),
//                                             getContainer(
//                                               image:
//                                                   "assets/pre_embryo_pic.svg",
//                                               text: "Post Embryo",
//                                               text2: "14-18 days",
//                                               text3: "Comingsoon",
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: MySize.getHeight(5)),
//                                       ],
//                                     ),
//                                   ),
//                                   Spacing.height(60),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               );
//             },
//           ));
//         });
//   }
//
//   Widget getCard(
//       {required BuildContext context,
//       required int index,
//       required ProcuduresController controller}) {
//     return Obx(() {
//       return Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//             MySize.getHeight(10),
//           ),
//         ),
//         child: Container(
//           height: MySize.getHeight(56),
//           width: MySize.getWidth(327),
//           padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(15)),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: (controller.isRecentlyAddedOrEditedProcedureDbId.value ==
//                     controller.procedures[index].id!)
//                 ? appTheme.primaryTheme.withOpacity(0.3)
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(
//               MySize.getHeight(10),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     controller.procedures[index].name!,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget getContainer(
//       {String image = "assets/egg_pic01.svg",
//       String text = "Egg Donor",
//       String text2 = "14-18 days",
//       String text3 = "Create",
//       bool isEnable = false}) {
//     return InkWell(
//       onTap: () {
//         if (text == "Egg Donor") {
//           Get.toNamed(Routes.CREATE_PROCEDURE_DEFINE);
//         }
//       },
//       child: Container(
//         height: MySize.getHeight(151),
//         width: MySize.getWidth(98),
//         decoration: BoxDecoration(
//           color: (isEnable)
//               ? ColorConstant.red50
//               : ColorConstant.red50.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(MySize.getHeight(15)),
//           boxShadow: appTheme.getShadow,
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: MySize.getHeight(28)),
//             SvgPicture.asset(
//               image,
//             ),
//             SizedBox(height: MySize.getHeight(9)),
//             Text(
//               text,
//               style: TextStyle(
//                   fontSize: MySize.getHeight(13.5),
//                   color:
//                       (isEnable) ? Colors.black : Colors.black.withOpacity(0.4),
//                   fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: MySize.getHeight(3)),
//             Text(
//               text2,
//               style: TextStyle(
//                   fontSize: MySize.getHeight(12),
//                   color:
//                       (isEnable) ? Colors.black : Colors.black.withOpacity(0.4),
//                   fontWeight: FontWeight.w300),
//             ),
//             SizedBox(height: MySize.getHeight(9)),
//             Text(
//               text3,
//               style: TextStyle(
//                   fontSize: MySize.getHeight(11),
//                   color: (isEnable)
//                       ? Color(0xffFD7E5C)
//                       : Color(0xffFD7E5C).withOpacity(0.3),
//                   fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
