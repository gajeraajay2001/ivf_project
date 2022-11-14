import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../controllers/create_account_patient_controller.dart';

class CreateAccountPatientView
    extends GetWidget<CreateAccountPatientController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: appTheme.backgroundTheme,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MySize.size64),
                  Text(
                    "Welcome to the Team !!",
                    style: TextStyle(
                        fontSize: MySize.getHeight(36),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySize.getHeight(29)),
                  Row(
                    children: [
                      Image.asset("assets/patient_avatar.png",
                          width: MySize.getWidth(40),
                          height: MySize.getHeight(40)),
                      SizedBox(width: MySize.getWidth(11)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You are already registered by",
                            style: TextStyle(fontSize: MySize.getHeight(16)),
                          ),
                          Text(
                            "“Dr. Ruchitha Singh”",
                            style: TextStyle(
                              fontSize: MySize.getHeight(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.getHeight(57)),
                  Text(
                    "Are you",
                    style: TextStyle(
                        color: appTheme.textGrayColor,
                        fontSize: MySize.getHeight(16)),
                  ),
                  SizedBox(height: MySize.size8),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // controller.isAgent.value = false;
                          // controller.isProfessional.value = false;
                          // controller.isPatient.value = true;
                          // Get.toNamed(Routes.CREATE_ACCOUNT_PATIENT);
                        },
                        child: getCard(
                          image: "assets/id_card.svg",
                          text: "Patient",
                          isSelected: controller.isPatient.value,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // controller.isAgent.value = false;
                          // controller.isProfessional.value = true;
                          // controller.isPatient.value = false;
                        },
                        child: getCard(
                          image: "assets/user_circle.svg",
                          text: "Doctor",
                          isSelected: controller.isProfessional.value,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // controller.isAgent.value = true;
                          // controller.isProfessional.value = false;
                          // controller.isPatient.value = false;
                        },
                        child: getCard(
                          image: "assets/user_voice.svg",
                          text: "Agent",
                          isSelected: controller.isAgent.value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.size28),
                  Text(
                    "Full name",
                    style: TextStyle(
                        color: appTheme.textGrayColor,
                        fontSize: MySize.getHeight(16)),
                  ),
                  SizedBox(height: MySize.size8),
                  Container(
                    child: getTextField(
                        textEditingController: controller.fullNameController,
                        hintText: "Eg: Jothsna Vibhavi"),
                  ),
                  SizedBox(height: MySize.getHeight(28)),
                  Text(
                    "Email Address (Optional)",
                    style: TextStyle(
                        color: appTheme.textGrayColor,
                        fontSize: MySize.getHeight(16)),
                  ),
                  SizedBox(height: MySize.size8),
                  Container(
                    child: getTextField(
                        textEditingController: controller.emailController,
                        hintText: "Jothsna@mediciti.com"),
                  ),
                  SizedBox(height: MySize.getHeight(28)),
                  Text(
                    "Patient profile",
                    style: TextStyle(
                        color: appTheme.textGrayColor,
                        fontSize: MySize.getHeight(16)),
                  ),
                  SizedBox(height: MySize.size8),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: getCard2(
                          text: "Egg Donor",
                          isSelected: controller.isEggDonor.value,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: getCard2(
                          text: "Doctor",
                          isSelected: controller.isSurrogate.value,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: getCard2(
                          text: "Agent",
                          isSelected: controller.isEggSeeker.value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.getHeight(50)),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.toNamed(Routes.FTUE_PATIENT);
                      },
                      child: getButton(
                          text: "Next", textColor: appTheme.primaryTheme)),
                  SizedBox(height: MySize.getHeight(35)),
                ],
              ),
            ),
          )),
    );
  }

  Card getCard(
      {required String image, required String text, bool isSelected = false}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.size10!)),
      child: Container(
        height: MySize.getHeight(74),
        width: MySize.getWidth(96.2),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image,
                color: (isSelected) ? appTheme.primaryTheme : Color(0xff777777),
                width: MySize.getWidth(25),
                height: MySize.getHeight(20)),
            SizedBox(height: MySize.getHeight(7)),
            Text(
              text,
              style: TextStyle(
                  color:
                      (isSelected) ? appTheme.primaryTheme : Color(0xff777777),
                  fontWeight: FontWeight.w400,
                  fontSize: MySize.getHeight(16)),
            ),
          ],
        ),
      ),
    );
  }

  Card getCard2({required String text, bool isSelected = false}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.size10!)),
      child: Container(
        height: MySize.getHeight(48),
        width: MySize.getWidth(96),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: (isSelected) ? appTheme.primaryTheme : Color(0xff777777),
              fontWeight: FontWeight.w400,
              fontSize: MySize.getHeight(14)),
        ),
      ),
    );
  }
}
