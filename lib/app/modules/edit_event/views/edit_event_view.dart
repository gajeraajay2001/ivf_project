import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import '../../../constants/api_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/color_constant.dart';
import '../controllers/edit_event_controller.dart';

class EditEventView extends GetWidget<EditEventController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          backgroundColor: ColorConstant.red50,
          body: (controller.hasData.isFalse)
              ? Center(
                  child:
                      CircularProgressIndicator(color: appTheme.primaryTheme),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: MySize.getWidth(17)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MySize.getHeight(40)),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(height: MySize.getHeight(26)),
                        Text(
                          "Edit Event",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(25)),
                        ),
                        SizedBox(height: MySize.getHeight(27)),
                        Text("Event Type",
                            style: TextStyle(fontSize: MySize.getHeight(14))),
                        SizedBox(height: MySize.getHeight(8)),
                        PopupMenuButton(
                          itemBuilder: (context) => List.generate(
                              controller.eventDataList.length, (index) {
                            return PopupMenuItem(
                              child: SizedBox(
                                  width: MySize.screenWidth,
                                  child: Text(
                                      controller.eventDataList[index].title!)),
                              enabled: true,
                              onTap: () {
                                controller.eventTypeController.value.text =
                                    controller.eventDataList[index].title!;
                                controller.selectedEvent =
                                    controller.eventDataList[index];
                                controller.eventTypeController.refresh();
                              },
                            );
                          }),
                          enabled: true,
                          offset: Offset(0, MySize.getHeight(52)),
                          child: Container(
                            height: MySize.getHeight(52),
                            padding: EdgeInsets.only(
                                left: MySize.getWidth(20),
                                right: MySize.getWidth(15)),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MySize.size10!),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.eventTypeController.value.text),
                                Icon(Icons.expand_more,
                                    size: MySize.getHeight(35),
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.getHeight(15)),
                        Text("Event Name",
                            style: TextStyle(fontSize: MySize.getHeight(14))),
                        SizedBox(height: MySize.getHeight(8)),
                        getTextField(
                            hintText: "Sonar Scan Report - I",
                            textEditingController:
                                controller.eventNameController.value),
                        SizedBox(height: MySize.getHeight(15)),
                        Text("On the day",
                            style: TextStyle(fontSize: MySize.getHeight(14))),
                        SizedBox(height: MySize.getHeight(8)),
                        getTextField(
                            hintText: "7",
                            readOnly: true,
                            textEditingController:
                                controller.dayController.value,
                            textInputType: TextInputType.number,
                            suffixIcon: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PATIENT_CALENDAR,
                                    arguments: {
                                      ArgumentConstant.asDoctor: true,
                                      ArgumentConstant.selectedDate:
                                          DateFormat("dd MMMM yyyy")
                                              .parse(controller.previousDate),
                                      ArgumentConstant
                                              .isForEditEventFromPatientTracker:
                                          true,
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(13),
                                child: SvgPicture.asset(
                                  "assets/calendar_icon.svg",
                                  height: MySize.getHeight(18),
                                  width: MySize.getWidth(18),
                                ),
                              ),
                            )),
                        SizedBox(height: MySize.getHeight(23)),
                        Text("Extra Instructions",
                            style: TextStyle(fontSize: MySize.getHeight(14))),
                        SizedBox(height: MySize.getHeight(8)),
                        getTextField(
                            hintText: "Enter Notes",
                            textEditingController:
                                controller.eventNoteController.value,
                            maxLine: 4),
                        SizedBox(height: MySize.getHeight(32)),
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(
                        //       "assets/notification_icon.svg",
                        //       height: MySize.getHeight(16),
                        //       width: MySize.getWidth(16),
                        //     ),
                        //     SizedBox(width: MySize.getWidth(10)),
                        //     Text(
                        //       "Don’t Show on Calendar",
                        //       style: TextStyle(fontSize: MySize.getHeight(14)),
                        //     ),
                        //     Spacer(),
                        //     CupertinoSwitch(
                        //         value: controller.isShowOnCalendar.value,
                        //         activeColor: appTheme.primaryTheme,
                        //         onChanged: (val) {
                        //           controller.isShowOnCalendar.value = val;
                        //         }),
                        //   ],
                        // ),
                        // SizedBox(height: MySize.getHeight(40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //     height: MySize.getHeight(56),
                            //     width: MySize.getWidth(56),
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(
                            //             MySize.getHeight(5))),
                            //     child:
                            //         SvgPicture.asset("assets/delete_icon.svg")),
                            // SizedBox(width: MySize.getWidth(16)),
                            InkWell(
                              onTap: () {
                                bool isAllOk = true;
                                if (isNullEmptyOrFalse(controller
                                    .eventNameController.value.text)) {
                                  isAllOk = false;
                                  getSnackBar(
                                      context: context,
                                      text: "Please enter event name.");
                                }
                                if (isNullEmptyOrFalse(
                                    controller.dayController.value.text)) {
                                  isAllOk = false;
                                  getSnackBar(
                                      context: context,
                                      text: "Please enter day");
                                }
                                if (isAllOk) {
                                  controller.callUpdateProcedureEvent(
                                      context: context);
                                }
                              },
                              child: Container(
                                width: MySize.getWidth(249),
                                height: MySize.getHeight(60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(15)),
                                  color: appTheme.primaryTheme,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MySize.getHeight(18)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.getHeight(27)),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
