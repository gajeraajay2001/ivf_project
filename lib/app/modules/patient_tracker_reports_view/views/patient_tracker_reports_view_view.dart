import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

import '../controllers/patient_tracker_reports_view_controller.dart';

class PatientTrackerReportsViewView
    extends GetWidget<PatientTrackerReportsViewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientTrackerReportsViewController>(
        init: PatientTrackerReportsViewController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: appTheme.backgroundTheme,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space.height(25),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Center(
                        child: Text(
                          "Page Under Development",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: MySize.getHeight(16),
                          ),
                        ),
                      ),
                    ),
                    Spacing.height(25),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: MySize.getWidth(17)),
                      child: Row(
                        children: [
                          Text(
                            "Egg Donor IVF 1A",
                            style: TextStyle(
                                fontSize: MySize.getHeight(18),
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Ongoing",
                            style: TextStyle(
                                fontSize: MySize.getHeight(11),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Spacing.height(5),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Dr. Vidya Sharma",
                        style: TextStyle(
                            fontSize: MySize.getHeight(11),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Spacing.height(20),
                    getCard(
                        controller: controller,
                        text1: "12 Jun",
                        text2: "Sonar Scan - I",
                        text3: "112337893_SC.pdf",
                        image: "assets/images/success_icon.svg"),
                    Space.height(7),
                    getCard(
                        controller: controller,
                        text1: "12 Jun",
                        text2: "Sonar Scan - I",
                        text3: "112337893_SC.pdf",
                        image: "assets/images/success_icon.svg"),
                    Space.height(7),
                    getCard(
                        controller: controller,
                        text1: "12 Jun",
                        text2: "Sonar Scan - I",
                        text3: "112337893_SC.pdf",
                        image: "assets/images/success_icon.svg"),
                    Space.height(7),
                  ],
                ),
              ),
            ),
          );
        });
  }

  getCard({
    required PatientTrackerReportsViewController controller,
    required String text1,
    required String text2,
    required String text3,
    required String image,
  }) {
    return Neumorphic(
      style: NeumorphicStyle(
        shadowLightColorEmboss: Colors.white10,
        color: appTheme.backgroundTheme,
      ),
      child: Container(
        height: MySize.getHeight(74),
        width: MySize.getWidth(358),
        // padding: EdgeInsets.symmetric(
        //   horizontal: MySize.getWidth(17),
        //   vertical: MySize.getHeight(15),
        // ),
        child: ListTile(
          minLeadingWidth: MySize.getWidth(30),
          leading: Container(
            height: MySize.getHeight(35),
            width: MySize.getWidth(35),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFFE0F2),
            ),
            child: Image.asset("assets/sonar_icon01.png"),
          ),
          title: Text(
            text2,
            style: TextStyle(
                fontSize: MySize.getHeight(14), fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            text3,
            style: TextStyle(
                fontSize: MySize.getHeight(12), fontWeight: FontWeight.w300),
          ),
          trailing: Container(
            child: Text(
              "Uploaded 12:30 PM 12/09/2021\nby RamGopal Verma",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: MySize.getHeight(10)),
            ),
          ),
        ),
      ),
    );
  }
}
