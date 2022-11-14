import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';

import '../../../constants/sizeConstant.dart';
import '../controllers/patient_tracker_profile_view_controller.dart';

class PatientTrackerProfileViewView
    extends GetWidget<PatientTrackerProfileViewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientTrackerProfileViewController>(
        init: PatientTrackerProfileViewController(),
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
                    Space.height(25),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Past Procedure Data",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: MySize.getHeight(16),
                        ),
                      ),
                    ),
                    Space.height(24),
                    getCard(
                        controller: controller,
                        text1: "12 Jun",
                        text2: "Egg Retreival",
                        text3: "Dr. Jhahnavi Patil",
                        image: "assets/images/success_icon.svg"),
                    Space.height(7),
                    getCard(
                        controller: controller,
                        text1: "11 May",
                        text2: "Egg Retreival",
                        text3: "Dr. Jhahnavi Patil",
                        image: "assets/images/terminated_icon.svg"),
                    Space.height(40),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Patient Information",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: MySize.getHeight(16),
                        ),
                      ),
                    ),
                    Space.height(20),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                          fontSize: MySize.getHeight(13),
                        ),
                      ),
                    ),
                    Space.height(10),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "12 May 1996",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.getHeight(14),
                        ),
                      ),
                    ),
                    Space.height(20),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "AADHAR Card No.",
                        style: TextStyle(
                          fontSize: MySize.getHeight(13),
                        ),
                      ),
                    ),
                    Space.height(10),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "5460 6565 5686",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.getHeight(14),
                        ),
                      ),
                    ),
                    Space.height(20),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Aadhar - Mobile number",
                        style: TextStyle(
                          fontSize: MySize.getHeight(13),
                        ),
                      ),
                    ),
                    Space.height(10),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "98129 87128",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.getHeight(14),
                        ),
                      ),
                    ),
                    Space.height(10),
                    Padding(
                      padding: EdgeInsets.only(left: MySize.getWidth(17)),
                      child: Text(
                        "Aadhar Photos",
                        style: TextStyle(
                          fontSize: MySize.getHeight(14),
                        ),
                      ),
                    ),
                    Center(child: Image.asset("assets/adhar_icon.png")),
                    Space.height(10),
                  ],
                ),
              ),
            ),
          );
        });
  }

  getCard({
    required PatientTrackerProfileViewController controller,
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
          minLeadingWidth: MySize.getWidth(70),
          leading: Text(text1),
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
          trailing: SvgPicture.asset(image),
        ),
      ),
    );
  }
}
