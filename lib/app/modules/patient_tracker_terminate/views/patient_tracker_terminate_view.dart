import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../../../../main.dart';
import '../controllers/patient_tracker_terminate_controller.dart';

class PatientTrackerTerminateView
    extends GetView<PatientTrackerTerminateController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.backgroundTheme,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MySize.getHeight(40)),
                  Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(10)),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back,
                              size: MySize.getHeight(25)))),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: MySize.getWidth(18)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MySize.getHeight(16)),
                        Text(
                          "Terminate",
                          style: TextStyle(
                            fontSize: MySize.getHeight(25),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: MySize.getHeight(33)),
                        Text(
                          "Termination Date",
                          style: TextStyle(fontSize: MySize.getHeight(14)),
                        ),
                        SizedBox(height: MySize.getHeight(8)),
                        Container(
                          height: MySize.getHeight(48),
                          width: MySize.getWidth(319),
                          child: getTextField(
                            onTap: () async {
                              DateTime? dateTime =
                                  await openCalendar(context: context);
                              if (!isNullEmptyOrFalse(dateTime)) {
                                controller.selectedDate.value.text =
                                    DateFormat("dd-MMM-yyyy").format(dateTime!);
                              }
                            },
                            textEditingController:
                                controller.selectedDate.value,
                            readOnly: true,
                            suffix: Padding(
                                padding:
                                    EdgeInsets.only(right: MySize.getWidth(5)),
                                child: SvgPicture.asset(
                                    "assets/calendar_icon.svg")),
                          ),
                        ),
                        SizedBox(height: MySize.getHeight(30)),
                        Text(
                          "Termination  Reason",
                          style: TextStyle(fontSize: MySize.getHeight(14)),
                        ),
                        SizedBox(height: MySize.getHeight(7)),
                        getCheckBox(
                            value: controller.reason1,
                            reason: "Poor Quality of Eggs"),
                        getCheckBox(
                            value: controller.reason2,
                            reason: "Failed Sonography Report"),
                        getCheckBox(
                            value: controller.reason3,
                            reason: "Insuffiecient Follicle Density (fd)"),
                        SizedBox(height: MySize.getHeight(30)),
                        Text(
                          "Extra Instructions",
                          style: TextStyle(fontSize: MySize.getHeight(14)),
                        ),
                        SizedBox(height: MySize.getHeight(8)),
                        getTextField(
                          hintText: "Enter Note",
                          maxLine: 5,
                          textInputAction: TextInputAction.newline,
                          textEditingController: controller.noteController,
                        ),
                        SizedBox(height: MySize.getHeight(52)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   height: MySize.getHeight(56),
                              //   width: MySize.getWidth(56),
                              //   decoration: BoxDecoration(
                              //     borderRadius:
                              //         BorderRadius.circular(MySize.getHeight(10)),
                              //     color: Colors.white,
                              //   ),
                              //   alignment: Alignment.center,
                              //   child: SizedBox(
                              //     height: MySize.getHeight(24),
                              //     width: MySize.getWidth(19),
                              //     child: SvgPicture.asset(
                              //       "assets/delete_icon.svg",
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(width: MySize.getHeight(16)),
                              InkWell(
                                onTap: () {
                                  controller.terminateProcedure(
                                      context: context,
                                      userId: box
                                          .read(ArgumentConstant.getUserDbId));
                                },
                                child: Container(
                                  height: MySize.getHeight(60),
                                  width: MySize.getWidth(249),
                                  decoration: BoxDecoration(
                                    color: appTheme.primaryTheme,
                                    borderRadius: BorderRadius.circular(
                                        MySize.getHeight(10)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MySize.getHeight(18)),
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(height: MySize.getHeight(30)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<DateTime?> openCalendar({required BuildContext context}) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1, 1),
        lastDate: DateTime(2023, 1, 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: appTheme.primaryTheme,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MySize.getWidth(20),
                      vertical: MySize.getHeight(5)),
                  alignment: Alignment.center,
                  child: child,
                ),
              ],
            ),
          );
        });
  }

  getCheckBox({
    required RxBool value,
    required String reason,
  }) {
    return SizedBox(
      height: MySize.getHeight(38),
      child: Row(
        children: [
          Checkbox(
            value: value.value,
            activeColor: appTheme.orangeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.getHeight(3))),
            onChanged: (val) {
              value.value = val!;
            },
          ),
          Text(
            reason,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
