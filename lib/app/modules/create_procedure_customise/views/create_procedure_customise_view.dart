import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../controllers/create_procedure_customise_controller.dart';

class CreateProcedureCustomiseView
    extends GetWidget<CreateProcedureCustomiseController> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        disableBarrierInteraction: true,
        onFinish: () {},
        builder: Builder(
          builder: (context) {
            if (controller.isTourStarted.value &&
                controller.tourViewed.isFalse &&
                controller.isDragAddCompleted.isFalse) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Future.delayed(Duration(milliseconds: 300), () {
                  ShowCaseWidget.of(context).startShowCase([
                    controller.day01ShowCaseKey.value,
                    controller.addDayShowCaseKey.value,
                    controller.allEventsShowCaseKey.value,
                    // controller.deleteEventsShowCaseKey.value,
                    // controller.nextButtonShowCaseKey.value,
                  ]);
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
                      topWidget(controller: controller),
                      Showcase.withWidget(
                        key: controller.allEventsShowCaseKey.value,
                        height: MySize.getHeight(40),
                        width: MySize.getWidth(200),
                        onTargetClick: () {
                          ShowCaseWidget.of(context).next();
                        },
                        container: Stack(
                          children: [
                            Positioned(
                              left: MySize.getWidth(20),
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
                            Container(
                              margin: EdgeInsets.only(top: MySize.getHeight(9)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.getWidth(20),
                                  vertical: MySize.getHeight(5)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MySize.getWidth(300),
                                    child: Text(
                                        "You can drag & drop events from this sheet to the intended days."),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        overlayPadding: EdgeInsets.symmetric(
                            vertical: MySize.getHeight(10),
                            horizontal: MySize.getWidth(10)),
                        overlayColor: Colors.transparent,
                        overlayOpacity: 0.2,
                        showcaseBackgroundColor: Colors.white,
                        child: eventsListWidget(
                            controller: controller, context: context),
                      ),
                      SizedBox(height: MySize.getHeight(0)),
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (!isNullEmptyOrFalse(controller.targetItem))
                            GridView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.targetItem.length + 1,
                              padding: EdgeInsets.only(
                                top: MySize.getHeight(10),
                                bottom: MySize.getHeight(20),
                                left: MySize.getWidth(15),
                                right: MySize.getWidth(15),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: MySize.getWidth(10),
                                      mainAxisSpacing: MySize.getHeight(15),
                                      childAspectRatio: MySize.getHeight(1.70),
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return DragTarget<DragItem>(
                                  builder: (
                                    BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected,
                                  ) {
                                    if (index == 0) {
                                      return getFirstEventBoxForTour(
                                          context: context,
                                          index: index,
                                          controller: controller);
                                    } else if (index ==
                                            controller
                                                .eventAddedForTourIndex.value &&
                                        controller.isDragAddCompleted.isTrue) {
                                      return getDeleteEventBoxForTour(
                                          context: context,
                                          index: index,
                                          controller: controller);
                                    } else if (index + 1 <=
                                        controller.targetItem.length) {
                                      return getAllEventBox(
                                          controller: controller,
                                          context: context,
                                          index: index);
                                    } else {
                                      return getAddDayBox(
                                          context: context,
                                          index: index,
                                          controller: controller);
                                    }
                                  },
                                  onWillAccept: (data) {
                                    return true;
                                  },
                                  onAccept: (data) {
                                    if (controller.isDragStarted.isTrue) {
                                      if (controller.isAddedPatients.isTrue) {
                                        controller
                                            .callUpdatePatientProcedureEvent(
                                                context: context,
                                                dragItem: data,
                                                index: index,
                                                detail: controller
                                                    .targetItem[index])
                                            .then((value) {});
                                      } else {
                                        controller
                                            .callUpdateProcedureEvent(
                                                context: context,
                                                dragItem: data,
                                                index: index,
                                                detail: controller
                                                    .targetItem[index])
                                            .then((value) {});
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          if (controller.isDeleteStarted.isTrue)
                            deleteEvents(
                                context: context, controller: controller)
                        ],
                      )),
                      assignedProcedureButton(
                          controller: controller, context: context),
                    ],
                  ),
                );
              }),
            );
          },
        ));
  }

  /*** Events Boxes ***/

  Widget getFirstEventBoxForTour(
      {required BuildContext context,
      required int index,
      required CreateProcedureCustomiseController controller}) {
    return Showcase.withWidget(
      key: controller.day01ShowCaseKey.value,
      height: MySize.getHeight(40),
      width: MySize.getWidth(200),
      onTargetClick: () {
        controller.scrollController
            .jumpTo(controller.scrollController.position.maxScrollExtent);
        ShowCaseWidget.of(context).next();
      },
      container: Stack(
        children: [
          Positioned(
            left: MySize.getWidth(20),
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
          Container(
            margin: EdgeInsets.only(top: MySize.getHeight(9)),
            padding: EdgeInsets.symmetric(
                horizontal: MySize.getWidth(20), vertical: MySize.getHeight(5)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(MySize.getHeight(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Day 01 is when menstural cycle starts."),
                Spacing.height(5),
                InkWell(
                  onTap: () {
                    controller.scrollController.jumpTo(
                        controller.scrollController.position.maxScrollExtent);
                    ShowCaseWidget.of(context).next();
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: appTheme.primaryTheme),
                  ),
                ),
              ],
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
        decoration: BoxDecoration(
            color: ColorConstant.red50,
            boxShadow: appTheme.getShadow,
            borderRadius: BorderRadius.circular(MySize.getHeight(10))),
        padding: EdgeInsets.symmetric(
            horizontal: MySize.getWidth(14), vertical: MySize.getHeight(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Day ${(controller.targetItem[index].day).toString().padLeft(2, '0')}",
              style: TextStyle(
                  color: Color(0xffBD6A8D),
                  fontSize: MySize.getHeight(15),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MySize.getHeight(10)),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                      controller.targetItem[index].events!.length, (index2) {
                    return (index2 ==
                                controller.targetItem[index].events!.length -
                                    1 &&
                            index == controller.eventAddedForTourIndex.value &&
                            !isNullEmptyOrFalse(
                                controller.targetItem[index].events))
                        ? Showcase.withWidget(
                            key: controller.deleteEventsShowCaseKey.value,
                            height: MySize.getHeight(40),
                            width: MySize.getWidth(200),
                            onTargetClick: () {
                              ShowCaseWidget.of(context).next();
                            },
                            container: Stack(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: MySize.getHeight(9)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize.getWidth(20),
                                      vertical: MySize.getHeight(5)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: MySize.getWidth(150),
                                          child: Text(
                                              "You can delete not needed tests/events/medications.")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            overlayPadding: EdgeInsets.symmetric(
                                vertical: MySize.getHeight(10),
                                horizontal: MySize.getWidth(10)),
                            overlayColor: Colors.transparent,
                            overlayOpacity: 0.2,
                            showcaseBackgroundColor: Colors.white,
                            child: Draggable(
                              data: [
                                controller.targetItem[index].events![index2],
                                index
                              ],
                              feedback: Container(
                                height: MySize.getHeight(44),
                                width: MySize.getWidth(44),
                                decoration: BoxDecoration(
                                    color: Color(0xff767579).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(
                                        MySize.getHeight(10))),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  controller
                                      .targetItem[index].events![index2].image
                                      .toString(),
                                  height: MySize.getHeight(24),
                                  width: MySize.getWidth(24),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    depth: MySize.getHeight(2),
                                    shape: NeumorphicShape.concave,
                                    color: appTheme.backgroundTheme,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(
                                            MySize.getHeight(10)))),
                                margin: EdgeInsets.only(
                                    right: MySize.getWidth(5),
                                    bottom: MySize.getHeight(5)),
                                child: Container(
                                  height: MySize.getHeight(38),
                                  width: MySize.getWidth(38),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    controller
                                        .targetItem[index].events![index2].image
                                        .toString(),
                                    height: MySize.getHeight(22),
                                    width: MySize.getWidth(22),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onDragStarted: () {
                                controller.isDeleteStarted.value = true;
                                controller.isDragStarted.value = false;
                                controller.deleteIndex.value = index;
                                controller.deleteImageIndex.value = index2;
                              },
                              onDragEnd: (val) {
                                controller.isDeleteStarted.value = false;
                              },
                              onDragCompleted: () {
                                controller.isDeleteStarted.value = false;
                              },
                            ),
                          )
                        : Draggable(
                            data: [
                              controller.targetItem[index].events![index2],
                              index
                            ],
                            feedback: Container(
                              height: MySize.getHeight(44),
                              width: MySize.getWidth(44),
                              decoration: BoxDecoration(
                                  color: Color(0xff767579).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(10))),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                controller
                                    .targetItem[index].events![index2].image
                                    .toString(),
                                height: MySize.getHeight(24),
                                width: MySize.getWidth(24),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  depth: MySize.getHeight(2),
                                  shape: NeumorphicShape.concave,
                                  color: appTheme.backgroundTheme,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(
                                          MySize.getHeight(10)))),
                              margin: EdgeInsets.only(
                                  right: MySize.getWidth(5),
                                  bottom: MySize.getHeight(5)),
                              child: Container(
                                height: MySize.getHeight(38),
                                width: MySize.getWidth(38),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  controller
                                      .targetItem[index].events![index2].image
                                      .toString(),
                                  height: MySize.getHeight(22),
                                  width: MySize.getWidth(22),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            onDragStarted: () {
                              controller.isDeleteStarted.value = true;
                              controller.isDragStarted.value = false;
                              controller.deleteIndex.value = index;
                              controller.deleteImageIndex.value = index2;
                            },
                            onDragEnd: (val) {
                              controller.isDeleteStarted.value = false;
                            },
                            onDragCompleted: () {
                              controller.isDeleteStarted.value = false;
                            },
                          );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAllEventBox(
      {required BuildContext context,
      required int index,
      required CreateProcedureCustomiseController controller}) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.red50,
          boxShadow: appTheme.getShadow,
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      padding: EdgeInsets.symmetric(
          horizontal: MySize.getWidth(14), vertical: MySize.getHeight(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Day ${(controller.targetItem[index].day).toString().padLeft(2, '0')}",
            style: TextStyle(
                color: Color(0xffBD6A8D),
                fontSize: MySize.getHeight(15),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: MySize.getHeight(10)),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                    controller.targetItem[index].events!.length, (index2) {
                  return Draggable(
                    data: [controller.targetItem[index].events![index2], index],
                    feedback: Container(
                      height: MySize.getHeight(44),
                      width: MySize.getWidth(44),
                      decoration: BoxDecoration(
                          color: Color(0xff767579).withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(MySize.getHeight(10))),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        controller.targetItem[index].events![index2].image
                            .toString(),
                        height: MySize.getHeight(24),
                        width: MySize.getWidth(24),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: MySize.getHeight(2),
                          shape: NeumorphicShape.concave,
                          color: appTheme.backgroundTheme,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(MySize.getHeight(10)))),
                      margin: EdgeInsets.only(
                          right: MySize.getWidth(5),
                          bottom: MySize.getHeight(5)),
                      child: Container(
                        height: MySize.getHeight(38),
                        width: MySize.getWidth(38),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          controller.targetItem[index].events![index2].image
                              .toString(),
                          height: MySize.getHeight(22),
                          width: MySize.getWidth(22),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    onDragStarted: () {
                      controller.isDeleteStarted.value = true;
                      controller.isDragStarted.value = false;
                      controller.deleteIndex.value = index;
                      controller.deleteImageIndex.value = index2;
                    },
                    onDragEnd: (val) {
                      controller.isDeleteStarted.value = false;
                    },
                    onDragCompleted: () {
                      controller.isDeleteStarted.value = false;
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDeleteEventBoxForTour(
      {required BuildContext context,
      required int index,
      required CreateProcedureCustomiseController controller}) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.red50,
          boxShadow: appTheme.getShadow,
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      padding: EdgeInsets.symmetric(
          horizontal: MySize.getWidth(14), vertical: MySize.getHeight(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Day ${(controller.targetItem[index].day).toString().padLeft(2, '0')}",
            style: TextStyle(
                color: Color(0xffBD6A8D),
                fontSize: MySize.getHeight(15),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: MySize.getHeight(10)),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                    controller.targetItem[index].events!.length, (index2) {
                  return (index2 ==
                              controller.targetItem[index].events!.length - 1 &&
                          !isNullEmptyOrFalse(
                              controller.targetItem[index].events))
                      ? Showcase.withWidget(
                          key: controller.deleteEventsShowCaseKey.value,
                          height: MySize.getHeight(40),
                          width: MySize.getWidth(200),
                          onTargetClick: () {
                            ShowCaseWidget.of(context).next();
                          },
                          container: Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: MySize.getHeight(9)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: MySize.getWidth(20),
                                    vertical: MySize.getHeight(5)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        MySize.getHeight(10))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: MySize.getWidth(150),
                                        child: Text(
                                            "You can delete not needed tests/events/medications.")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          overlayPadding: EdgeInsets.symmetric(
                              vertical: MySize.getHeight(10),
                              horizontal: MySize.getWidth(10)),
                          overlayColor: Colors.transparent,
                          overlayOpacity: 0.2,
                          showcaseBackgroundColor: Colors.white,
                          child: Draggable(
                            data: [
                              controller.targetItem[index].events![index2],
                              index
                            ],
                            feedback: Container(
                              height: MySize.getHeight(44),
                              width: MySize.getWidth(44),
                              decoration: BoxDecoration(
                                  color: Color(0xff767579).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(10))),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                controller
                                    .targetItem[index].events![index2].image
                                    .toString(),
                                height: MySize.getHeight(24),
                                width: MySize.getWidth(24),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  depth: MySize.getHeight(2),
                                  shape: NeumorphicShape.concave,
                                  color: appTheme.backgroundTheme,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(
                                          MySize.getHeight(10)))),
                              margin: EdgeInsets.only(
                                  right: MySize.getWidth(5),
                                  bottom: MySize.getHeight(5)),
                              child: Container(
                                height: MySize.getHeight(38),
                                width: MySize.getWidth(38),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  controller
                                      .targetItem[index].events![index2].image
                                      .toString(),
                                  height: MySize.getHeight(22),
                                  width: MySize.getWidth(22),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            onDragStarted: () {
                              controller.isDeleteStarted.value = true;
                              controller.isDragStarted.value = false;
                              controller.deleteIndex.value = index;
                              controller.deleteImageIndex.value = index2;
                            },
                            onDragEnd: (val) {
                              controller.isDeleteStarted.value = false;
                            },
                            onDragCompleted: () {
                              controller.isDeleteStarted.value = false;
                            },
                          ),
                        )
                      : Draggable(
                          data: [
                            controller.targetItem[index].events![index2],
                            index
                          ],
                          feedback: Container(
                            height: MySize.getHeight(44),
                            width: MySize.getWidth(44),
                            decoration: BoxDecoration(
                                color: Color(0xff767579).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                    MySize.getHeight(10))),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              controller.targetItem[index].events![index2].image
                                  .toString(),
                              height: MySize.getHeight(24),
                              width: MySize.getWidth(24),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                depth: MySize.getHeight(2),
                                shape: NeumorphicShape.concave,
                                color: appTheme.backgroundTheme,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(
                                        MySize.getHeight(10)))),
                            margin: EdgeInsets.only(
                                right: MySize.getWidth(5),
                                bottom: MySize.getHeight(5)),
                            child: Container(
                              height: MySize.getHeight(38),
                              width: MySize.getWidth(38),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                controller
                                    .targetItem[index].events![index2].image
                                    .toString(),
                                height: MySize.getHeight(22),
                                width: MySize.getWidth(22),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onDragStarted: () {
                            controller.isDeleteStarted.value = true;
                            controller.isDragStarted.value = false;
                            controller.deleteIndex.value = index;
                            controller.deleteImageIndex.value = index2;
                          },
                          onDragEnd: (val) {
                            controller.isDeleteStarted.value = false;
                          },
                          onDragCompleted: () {
                            controller.isDeleteStarted.value = false;
                          },
                        );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAddDayBox(
      {required BuildContext context,
      required int index,
      required CreateProcedureCustomiseController controller}) {
    return Showcase.withWidget(
      key: controller.addDayShowCaseKey.value,
      height: MySize.getHeight(30),
      width: MySize.getWidth(150),
      onTargetClick: () {
        controller.scrollController
            .jumpTo(controller.scrollController.position.minScrollExtent);
        ShowCaseWidget.of(context).next();
      },
      shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      container: Stack(
        children: [
          Positioned(
            left: MySize.getWidth(20),
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
          Container(
            margin: EdgeInsets.only(top: MySize.getHeight(9)),
            padding: EdgeInsets.symmetric(
                horizontal: MySize.getWidth(20), vertical: MySize.getHeight(5)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(MySize.getHeight(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MySize.getWidth(300),
                  child: Text(
                      "This procedure is a 11 day procedure. If you wish to extend, Add more days."),
                ),
                Spacing.height(5),
                InkWell(
                  onTap: () {
                    controller.scrollController.jumpTo(
                        controller.scrollController.position.minScrollExtent);
                    ShowCaseWidget.of(context).next();
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: appTheme.primaryTheme),
                  ),
                ),
              ],
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
        height: MySize.getHeight(118),
        width: MySize.getWidth(160),
        decoration: BoxDecoration(
            color: Color(0xffF9E1EF),
            borderRadius: BorderRadius.circular(MySize.getHeight(10))),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            controller
                .callUpdateProcedureEvent(
                  context: context,
                  isForAddDay: true,
                  day: controller.targetItem.length + 1,
                  index: controller.targetItem.length + 1,
                )
                .then((value) {});
            // Get.toNamed(Routes.EDIT_EVENT,
            //     arguments: {
            //       ArgumentConstant.isForAddedPatient:
            //           controller
            //               .isAddedPatients.value,
            //       ArgumentConstant
            //               .addedPatientProcedureDbId:
            //           controller
            //               .addedPatientProcedureDbId
            //               .value
            //     });
          },
          child: SvgPicture.asset(
            "assets/add_day.svg",
            width: MySize.getWidth(86),
            height: MySize.getHeight(44),
          ),
        ),
      ),
    );
  }

  Widget deleteEvents(
      {required BuildContext context,
      required CreateProcedureCustomiseController controller}) {
    return Positioned(
        bottom: MySize.getHeight(-350),
        child: DragTarget<List>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              alignment: Alignment.topCenter,
              height: MySize.getHeight(434),
              width: MySize.getWidth(434),
              padding: EdgeInsets.only(top: MySize.getHeight(45)),
              decoration: BoxDecoration(
                  color: Color(0xffDEDEDE).withOpacity(0.6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 10,
                        color: Color(0xffDEDEDE).withOpacity(0.9),
                        blurRadius: 100),
                  ]),
              child: SvgPicture.asset("assets/delete_icon.svg"),
            );
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            if (controller.isDeleteStarted.isTrue) {
              if (controller.isAddedPatients.isTrue) {
                controller.callDeletePatientProcedureEvent(
                    context: context,
                    detail: controller.targetItem[data[1]],
                    events: data[0]);
              } else {
                controller.callDeleteProcedureEvent(
                    context: context,
                    detail: controller.targetItem[data[1]],
                    events: data[0]);
              }
            }
          },
        ));
  }

  /*** Events Boxes ***/

  topWidget({required CreateProcedureCustomiseController controller}) {
    return Container(
      color: appTheme.backgroundTheme,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: MySize.getWidth(17)),
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
              SizedBox(width: MySize.getWidth(21)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MySize.getWidth(180),
                    child: Text(
                      (controller.isProcedureView)
                          ? (!isNullEmptyOrFalse(controller.procedureName))
                              ? controller.procedureName
                              : "Modify Procedure"
                          : (!isNullEmptyOrFalse(controller.procedureName))
                              ? controller.procedureName
                              : "Create Procedure",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MySize.getHeight(18),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(2)),
                  Text(
                    "(Edit Mode)",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: MySize.getHeight(12),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset("assets/egg_pic02.svg"),
            ],
          ),
          SizedBox(height: MySize.getHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(40)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Define",
                    style: TextStyle(
                        color: appTheme.primaryTheme,
                        fontWeight: FontWeight.w500,
                        fontSize: MySize.getHeight(14)),
                  ),
                  Text(
                    "Customise",
                    style: TextStyle(
                        color: Color(0xffBD6A8D),
                        fontWeight: FontWeight.w500,
                        fontSize: MySize.getHeight(14)),
                  ),
                  Text(
                    "Review",
                    style: TextStyle(
                        color: Color(0xffBD6A8D),
                        fontWeight: FontWeight.w500,
                        fontSize: MySize.getHeight(14)),
                  ),
                ]),
          ),
          SizedBox(height: MySize.getHeight(16)),
          Center(
            child: Image(
              image: AssetImage("assets/Track02.png"),
              width: MySize.getWidth(281),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: MySize.getHeight(30)),
        ],
      ),
    );
  }

  Widget eventsListWidget(
      {required CreateProcedureCustomiseController controller,
      required BuildContext context}) {
    return Container(
        color: Colors.white,
        height: MySize.getHeight(100),
        width: MySize.getWidth(360),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  controller.dragItem.forEach((element) {
                    element.isActive!.value = false;
                  });
                  controller.dragItem[index].isActive!.value = true;
                  controller.dragItem.refresh();
                },
                child: Container(
                    width: MySize.getWidth(58),
                    alignment: Alignment.center,
                    child: Container(
                      child: Draggable(
                        child: Container(
                          width: MySize.getWidth(44),
                          height: MySize.getHeight(70),
                          decoration: BoxDecoration(
                              color:
                                  (controller.dragItem[index].isActive!.isTrue)
                                      ? appTheme.backgroundTheme
                                      : Colors.white,
                              border: Border.all(
                                color: (!controller
                                        .dragItem[index].isActive!.isTrue)
                                    ? appTheme.backgroundTheme
                                    : Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.circular(MySize.getHeight(8))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                controller.dragItem[index].image.toString(),
                                height: MySize.getHeight(24),
                                width: MySize.getWidth(24),
                                color: (controller.dragItem[index].image
                                            .toString() ==
                                        "624420e970c14f56956f3d1a")
                                    ? Color(0xff3C3366)
                                    : null,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: MySize.getHeight(10)),
                              Text(
                                controller.dragItem[index].name.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: MySize.getHeight(9)),
                              ),
                            ],
                          ),
                        ),
                        onDragStarted: () {
                          controller.dragItem.forEach((element) {
                            element.isActive!.value = false;
                          });
                          controller.dragItem[index].isActive!.value = true;
                          controller.dragItem.refresh();
                          controller.isDragStarted.value = true;
                        },
                        onDragCompleted: () {
                          controller.isDragStarted.value = false;
                        },
                        feedback: Container(
                          height: MySize.getHeight(44),
                          width: MySize.getWidth(44),
                          decoration: BoxDecoration(
                              color: Color(0xff767579).withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(MySize.getHeight(10))),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            controller.dragItem[index].image.toString(),
                            height: MySize.getHeight(24),
                            width: MySize.getWidth(24),
                            fit: BoxFit.contain,
                          ),
                        ),
                        childWhenDragging: SvgPicture.asset(
                          controller.dragItem[index].image.toString(),
                          height: MySize.getHeight(24),
                          width: MySize.getWidth(24),
                          fit: BoxFit.cover,
                        ),
                        data: controller.dragItem[index],
                      ),
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: MySize.getHeight(66),
                width: MySize.getWidth(1),
                child: VerticalDivider(
                    color: Color(0xffDDCBCE),
                    indent: MySize.getHeight(10),
                    endIndent: MySize.getHeight(16)),
              );
            },
            itemCount: controller.dragItem.length));
  }

  assignedProcedureButton(
      {required BuildContext context,
      required CreateProcedureCustomiseController controller}) {
    return Column(
      children: [
        SizedBox(height: MySize.getHeight(10)),
        Center(
          child: InkWell(
            onTap: () {
              if (controller.isWholeProcedureReview.isTrue) {
                if (controller.isAddedPatients.value) {
                  controller.callPatientProcedureAssignment(context: context);
                } else {
                  if (controller.isProcedureView) {
                    Get.toNamed(Routes.CREATE_PROCEDURE_REVIEW, arguments: {
                      ArgumentConstant.procedureDbId: controller.procedureDbId,
                      ArgumentConstant.isProcedureView: true,
                    });
                  } else {
                    Get.toNamed(Routes.CREATE_PROCEDURE_REVIEW);
                  }
                }
              } else {
                getGetXSnackBar(
                    title: "Error",
                    msg: "Please review whole procedure first.");
              }
            },
            child: Showcase.withWidget(
              key: controller.nextButtonShowCaseKey.value,

              height: MySize.getHeight(40),
              width: MySize.getWidth(200),
              // shapeBorder: RoundedRectangleBorder(
              //     borderRadius:
              //         BorderRadius.circular(
              //             MySize.getHeight(10))),
              onTargetClick: () {
                Get.toNamed(Routes.CREATE_PROCEDURE_REVIEW);
                ShowCaseWidget.of(context).next();
              },
              container: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: MySize.getWidth(20),
                    child: CustomPaint(
                      painter: Arrow(
                        strokeColor: Colors.white,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                        isUpArrow: false,
                      ),
                      child: SizedBox(
                        height: MySize.getHeight(9),
                        width: MySize.getWidth(18),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: MySize.getHeight(9)),
                    padding: EdgeInsets.symmetric(
                        horizontal: MySize.getWidth(20),
                        vertical: MySize.getHeight(5)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(MySize.getHeight(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MySize.getWidth(300),
                            child: Text(
                                "Click Next once you have configuration looks good.")),
                      ],
                    ),
                  ),
                ],
              ),
              overlayPadding: EdgeInsets.symmetric(
                  vertical: MySize.getHeight(10),
                  horizontal: MySize.getWidth(10)),
              overlayColor: Colors.transparent,
              overlayOpacity: 0.2,
              showcaseBackgroundColor: Colors.white,
              child: Container(
                width: MySize.getWidth(332),
                height: MySize.getHeight(56),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MySize.getHeight(15)),
                  color: (controller.isWholeProcedureReview.isTrue)
                      ? appTheme.primaryTheme
                      : appTheme.primaryTheme.withOpacity(0.6),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: (controller.isWholeProcedureReview.isTrue)
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      fontSize: MySize.getHeight(18)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MySize.getHeight(10)),
      ],
    );
  }
}

class DragItem {
  String? id;
  String? image;
  String? name;
  RxBool? isActive = false.obs;

  DragItem({this.id, this.image, this.name, this.isActive});
}

class TargetItem {
  String? id;
  String? name;
  RxList? imageList;

  TargetItem({this.id, this.name, this.imageList});
}

class Arrow extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final bool isUpArrow;

  Arrow(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke,
      this.isUpArrow = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    if (isUpArrow) {
      return Path()
        ..moveTo(0, y)
        ..lineTo(x / 2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);
    } else {
      return Path()
        ..moveTo(0, 0)
        ..lineTo(x, 0)
        ..lineTo(x / 2, y)
        ..lineTo(0, 0);
    }
  }

  @override
  bool shouldRepaint(Arrow oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
