import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';
import '../../../../main.dart';
import '../../../theme/app_style.dart';
import '../controllers/patient_home_controller.dart';

class PatientHomeView extends GetWidget<PatientHomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientHomeController>(
      init: PatientHomeController(),
      builder: (controller) {
        return Obx(() {
          return (controller.hasData.isFalse)
              ? Center(
                  child:
                      CircularProgressIndicator(color: appTheme.primaryTheme),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getAppBar(context: context, controller: controller),
                        SizedBox(height: MySize.getHeight(20)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MySize.getWidth(15),
                          ),
                          child: Text(
                            "Hi ${(!isNullEmptyOrFalse(box.read(ArgumentConstant.patientName))) ? box.read(ArgumentConstant.patientName) : "Patient"}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MySize.getHeight(22)),
                          ),
                        ),
                        SizedBox(height: MySize.getHeight(10)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MySize.getWidth(15),
                          ),
                          child: Text(
                            "Your Upcoming events.",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: MySize.getHeight(14)),
                          ),
                        ),
                        (controller.hasData.isFalse)
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: appTheme.primaryTheme,
                                ),
                              )
                            : (isNullEmptyOrFalse(
                                    controller.eggRetrivalDataList)
                                ? Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: MySize.getHeight(
                                                (controller.profileCheck.isTrue)
                                                    ? 30
                                                    : 70)),
                                        child:
                                            Text("you have no events yet..")),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MySize.getWidth(20),
                                        vertical: MySize.getHeight(15)),
                                    child: GroupedListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      elements: controller.eggRetrivalDataList,
                                      groupBy: (EggRetreivalDataModel element) {
                                        return element.dateTime;
                                      },
                                      groupHeaderBuilder:
                                          (EggRetreivalDataModel element) {
                                        return Row(
                                          children: [
                                            if (DateTime.now().day ==
                                                    element.dateTime!.day &&
                                                DateTime.now().month ==
                                                    element.dateTime!.month &&
                                                DateTime.now().year ==
                                                    element.dateTime!.year)
                                              Text("Today "),
                                            if (DateTime.now().day ==
                                                    element.dateTime!.day &&
                                                DateTime.now().month ==
                                                    element.dateTime!.month &&
                                                DateTime.now().year ==
                                                    element.dateTime!.year)
                                              Container(
                                                height: MySize.getHeight(5),
                                                width: MySize.getWidth(5),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black26),
                                              ),
                                            if (DateTime.now().day ==
                                                    element.dateTime!.day &&
                                                DateTime.now().month ==
                                                    element.dateTime!.month &&
                                                DateTime.now().year ==
                                                    element.dateTime!.year)
                                              SizedBox(
                                                  width: MySize.getWidth(2)),
                                            Text(DateFormat("dd MMM yyyy")
                                                .format(element.dateTime!)),
                                          ],
                                        );
                                      },
                                      indexedItemBuilder: (context,
                                          EggRetreivalDataModel element,
                                          index) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                              top: MySize.getHeight(15),
                                              left: MySize.getWidth(20)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height:
                                                        MySize.getHeight(25),
                                                    width: MySize.getWidth(25),
                                                    child: SvgPicture.asset(
                                                        "assets/image01.svg",
                                                        fit: BoxFit.cover,
                                                        height:
                                                            MySize.getHeight(
                                                                25),
                                                        width: MySize.getWidth(
                                                            25)),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MySize.getWidth(22)),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Egg Retrieval",
                                                        style: TextStyle(
                                                            fontSize: MySize
                                                                .getHeight(17),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              MySize.getHeight(
                                                                  2)),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Egg Retrieval ",
                                                            style: TextStyle(
                                                                fontSize: MySize
                                                                    .getHeight(
                                                                        13),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          Container(
                                                            height: MySize
                                                                .getHeight(5),
                                                            width:
                                                                MySize.getWidth(
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
                                                                fontSize: MySize
                                                                    .getHeight(
                                                                        13),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              MySize.getHeight(
                                                                  2)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MySize.getHeight(10)),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                        if (controller.profileCheck.isTrue)
                          SizedBox(height: MySize.getHeight(30)),
                        if (controller.profileCheck.isTrue)
                          getCompleteProfilePopUp(
                              context: context, controller: controller),
                        SizedBox(
                            height: MySize.getHeight(
                                (controller.profileCheck.isTrue) ? 20 : 60)),
                        InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PATIENT_CALENDAR, arguments: {
                                ArgumentConstant.asPatient: true,
                                ArgumentConstant.selectedDate: controller.msDate
                              });
                            },
                            child: getCalendarPopUp(
                                context: context, controller: controller)),
                        SizedBox(
                            height: MySize.getWidth(
                                (controller.profileCheck.isTrue) ? 30 : 60)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MySize.getWidth(15),
                          ),
                          child: Text(
                            "Pregnancy Advice",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MySize.getHeight(22)),
                          ),
                        ),
                        SizedBox(height: MySize.getWidth(40)),
                        Center(
                          child: Text(
                            "CONTENT UNDER DEVELOPMENT",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: MySize.getWidth(40)),
                      ],
                    ),
                  ),
                );
        });
      },
    );
  }

  getAppBar(
      {required BuildContext context,
      required PatientHomeController controller}) {
    return Container(
      width: double.infinity,
      height: MySize.getHeight(90),
      decoration: BoxDecoration(
        color: ColorConstant.pink50A2,
      ),
      child: Align(
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
                        style: AppStyle.textStyleDMSansmedium16.copyWith(
                          fontSize: MySize.getHeight(16),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MySize.getHeight(36),
                      width: MySize.getWidth(36),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              color: Colors.black26,
                              blurRadius: MySize.size2!,
                              spreadRadius: MySize.size2!,
                            ),
                            BoxShadow(
                              offset: Offset(-1, -1),
                              color: Colors.white,
                              blurRadius: MySize.size2!,
                              spreadRadius: MySize.size2!,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(2000),
                          color: appTheme.shadowColor),
                      // child:
                    ),
                    SvgPicture.asset(
                      "assets/noti_01.svg",
                      fit: BoxFit.cover,
                      height: MySize.getHeight(55),
                      width: MySize.getWidth(55),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCompleteProfilePopUp(
      {required BuildContext context,
      required PatientHomeController controller}) {
    return Padding(
      padding: EdgeInsets.only(left: MySize.getWidth(24)),
      child: Container(
        height: MySize.getHeight(138),
        width: MySize.screenWidth,
        decoration: BoxDecoration(
            color: Color(0xffFFF9E0),
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
                      color: appTheme.primaryTheme,
                      fontSize: MySize.getHeight(16)),
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

  Widget getCalendarPopUp(
      {required BuildContext context,
      required PatientHomeController controller}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Neumorphic(
        style: NeumorphicStyle(color: appTheme.backgroundTheme),
        child: Container(
          height: MySize.getHeight(76),
          width: MySize.getWidth(335),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(MySize.getHeight(10)),
                topLeft: Radius.circular(MySize.getHeight(10))),
          ),
          padding: EdgeInsets.only(left: MySize.getWidth(20)),
          child: Row(
            children: [
              SvgPicture.asset("assets/calendar_icon2.svg"),
              SizedBox(width: MySize.getWidth(20)),
              SizedBox(
                width: MySize.getWidth(221),
                child: Text(
                  "When did your current Menstural Cycle start?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
