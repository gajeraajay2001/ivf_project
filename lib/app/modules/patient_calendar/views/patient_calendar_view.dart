import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/patient_calendar_controller.dart';

class PatientCalendarView extends GetWidget<PatientCalendarController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: (controller.asDoctor)
              ? Color(0xffF2F3F7)
              : appTheme.backgroundTheme,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MySize.getHeight(60)),
                  (controller.asDoctor)
                      ? Center(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: MySize.getHeight(20)),
                              child: InkWell(
                                  onTap: () {
                                    print("Back .......... ");
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/close_icon.svg"))),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: MySize.getWidth(30)),
                                SvgPicture.asset(
                                  "assets/drop_icon.svg",
                                ),
                                SizedBox(width: MySize.getWidth(30)),
                                SizedBox(
                                  width: MySize.getWidth(254),
                                  child: Text(
                                    "When did your current Menstural Cycle start?",
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MySize.getHeight(15)),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: MySize.getWidth(80)),
                                child: Text(
                                  DateFormat("EEEE, MMM dd, yyyy")
                                      .format(controller.selectedDay.value),
                                  style: TextStyle(
                                      color: appTheme.primaryTheme,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                  SizedBox(height: MySize.getHeight(15)),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MySize.getWidth(15),
                          vertical: MySize.getHeight(0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: MySize.getWidth(15),
                          vertical: MySize.getHeight(0)),
                      decoration: BoxDecoration(
                          color: (controller.asDoctor)
                              ? Color(0xffF2F3F7)
                              : appTheme.backgroundTheme,
                          borderRadius: BorderRadius.circular(
                            MySize.getHeight(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.black38,
                              blurRadius: MySize.size5!,
                              spreadRadius: MySize.size5!,
                            ),
                            BoxShadow(
                              offset: Offset(-2, -2),
                              color: Colors.white,
                              blurRadius: MySize.size15!,
                              spreadRadius: MySize.size2!,
                            ),
                          ]),
                      child: Container(
                        // height: MySize.getHeight(450),
                        width: MySize.getWidth(328),
                        padding: EdgeInsets.only(bottom: MySize.getHeight(15)),
                        child: TableCalendar(
                          currentDay: controller.selectedDay.value,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: (controller.isForEditEventFromPatientTracker)
                              ? DateTime.utc(2030, 3, 14)
                              : (controller.asDoctor)
                                  ? DateTime.utc(2030, 3, 14)
                                  : DateTime.utc(2030, 3, 14),
                          focusedDay: controller.focusedDay.value,
                          // selectedDayPredicate: (day) {
                          //   return isSameDay(controller.selectedDay.value, day);
                          // },
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.selectedDay.value = selectedDay;
                            controller.focusedDay.value =
                                focusedDay; // update `_focusedDay` here as well
                          },
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black12)),
                            rightChevronIcon: SizedBox(
                                height: MySize.getHeight(15),
                                width: MySize.getWidth(15),
                                child:
                                    SvgPicture.asset("assets/right_icon.svg")),
                            leftChevronIcon: SizedBox(
                                height: MySize.getHeight(15),
                                width: MySize.getWidth(15),
                                child:
                                    SvgPicture.asset("assets/left_icon.svg")),
                            headerMargin: EdgeInsets.only(
                              left: MySize.getWidth(13),
                              right: MySize.getWidth(13),
                              top: MySize.getWidth(10),
                              bottom: MySize.getWidth(10),
                            ),
                          ),
                          onPageChanged: (focusDay) {
                            controller.focusedDay.value = focusDay;
                          },
                          calendarFormat: CalendarFormat.month,
                          daysOfWeekHeight: MySize.getHeight(25),
                          pageJumpingEnabled: false,
                          calendarBuilders: CalendarBuilders(
                              headerTitleBuilder: (context, day) {
                            return Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat("MMMM").format(day)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MySize.getHeight(18)),
                                  ),
                                  SizedBox(width: MySize.getWidth(10)),
                                  Text(
                                    "${DateFormat("yyyy").format(day)}",
                                    style: TextStyle(
                                        fontSize: MySize.getHeight(18)),
                                  ),
                                ],
                              ),
                            );
                          }, selectedBuilder: (context, day, _) {
                            return Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(53),
                              width: MySize.getWidth(43),
                              decoration: BoxDecoration(
                                color: Color(0xffFCF1F8),
                                border: Border.all(
                                  color: Color(0xffFF0D8C).withOpacity(0.4),
                                ),
                                borderRadius:
                                    BorderRadius.circular(MySize.getHeight(5)),
                              ),
                              child: Text(day.day.toString()),
                            );
                          }, outsideBuilder: (context, day, _) {
                            return Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(53),
                              width: MySize.getWidth(46),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: (controller.asDoctor)
                                        ? Colors.grey.shade300
                                        : Color(0xffF5F5F5)),
                                color: (controller.asDoctor)
                                    ? Color(0xffF2F3F7)
                                    : Color(0xffF7EFF4),
                                borderRadius:
                                    BorderRadius.circular(MySize.getHeight(5)),
                              ),
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.black12),
                              ),
                            );
                          }, dowBuilder: (context, day) {
                            return Center(
                              child: Text(
                                DateFormat("EEE").format(day),
                                style: TextStyle(
                                    color:
                                        (DateFormat("EEE").format(day) == "Sun")
                                            ? appTheme.primaryTheme
                                            : Color(0xff464646)),
                              ),
                            );
                          }, defaultBuilder: (context, day, _) {
                            return Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(55),
                              width: MySize.getWidth(50),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: (controller.asDoctor)
                                        ? Colors.grey.shade200
                                        : Color(0xffF5F5F5)),
                                borderRadius:
                                    BorderRadius.circular(MySize.getHeight(5)),
                              ),
                              child: Text(day.day.toString()),
                            );
                          }, todayBuilder: (context, day, _) {
                            return Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(53),
                              width: MySize.getWidth(43),
                              decoration: BoxDecoration(
                                color: (controller.asDoctor)
                                    ? Color(0xffF2F3F7)
                                    : Color(0xffFCF1F8),
                                border: Border.all(
                                  color: Color(0xffFF0D8C).withOpacity(0.4),
                                ),
                                borderRadius:
                                    BorderRadius.circular(MySize.getHeight(5)),
                              ),
                              child: (controller.isFormsCycleStartDateUpdate ||
                                      controller.asPatient)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/drop_icon.svg",
                                          height: MySize.getHeight(12),
                                          width: MySize.getWidth(12),
                                        ),
                                        Text(day.day.toString()),
                                      ],
                                    )
                                  : Text(day.day.toString()),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(58)),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (controller.isForEditEventFromPatientTracker) {
                          controller.editEventController!.dayController.value
                                  .text =
                              DateFormat("dd MMMM yyyy")
                                  .format(controller.selectedDay.value);
                          Get.back();
                        } else if (controller.isFormsCycleStartDateUpdate ||
                            controller.asPatient) {
                          controller.updateMsCycleDate(context: context);
                        } else {
                          controller
                              .assignProcedureScreenController!
                              .selectedDate
                              .value = controller.selectedDay.value;
                          controller.assignProcedureScreenController!
                                  .selectedDateString.value =
                              DateFormat("dd-MMMM-yyy")
                                  .format(controller.selectedDay.value);
                          controller.assignProcedureScreenController!
                              .isMcDateSelected.value = true;
                          Get.back();
                        }
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          color: appTheme.primaryTheme,
                          shadowDarkColor: appTheme.primaryTheme,
                        ),
                        child: Container(
                          height: MySize.getHeight(62),
                          width: MySize.getWidth(320),
                          decoration: BoxDecoration(
                            color: appTheme.primaryTheme,
                            borderRadius:
                                BorderRadius.circular(MySize.getHeight(10)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (controller.asDoctor)
                                ? (controller.isFormsCycleStartDateUpdate)
                                    ? "Update Ms Cycle Start Date"
                                    : "Save"
                                : "Save and Show my Schedule",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MySize.getHeight(18)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(26)),
                  (controller.asDoctor)
                      ? SizedBox()
                      : Center(
                          child: SizedBox(
                            width: MySize.getWidth(313),
                            child: Text(
                              "* Only Your Doctor will be able to change it if you change your mind later",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  SizedBox(height: MySize.getHeight(30)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
