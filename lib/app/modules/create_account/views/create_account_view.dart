import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import 'package:ivf_project/main.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetWidget<CreateAccountController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.backgroundTheme,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: appTheme.backgroundTheme,
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: MySize.getHeight(30)),
                      Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: MySize.getHeight(36),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Sign up to get started",
                        style: TextStyle(
                            fontSize: MySize.getHeight(14),
                            color: appTheme.textGrayColor),
                      ),
                      SizedBox(height: MySize.size38),
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
                              controller.isAgent.value = false;
                              controller.isDoctor.value = true;
                              controller.isPatient.value = false;
                            },
                            child: getCard(
                              image: "assets/user_circle.svg",
                              text: "Doctor",
                              isSelected: controller.isDoctor.value,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.isAgent.value = false;
                              controller.isDoctor.value = false;
                              controller.isPatient.value = true;
                            },
                            child: getCard(
                              image: "assets/id_card.svg",
                              text: "Patient",
                              isSelected: controller.isPatient.value,
                            ),
                          ),
                          getCard(
                            image: "assets/user_voice.svg",
                            text: "Agent",
                            isSelected: controller.isAgent.value,
                            isGreyOut: true,
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
                            textEditingController:
                                controller.fullNameController,
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
                              hintText: "Jothsna@mediciti.com")),
                      if (controller.isPatient.value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MySize.getHeight(28)),
                            Text(
                              "Mobile Number",
                              style: TextStyle(
                                  color: appTheme.textGrayColor,
                                  fontSize: MySize.getHeight(16)),
                            ),
                            SizedBox(height: MySize.size8),
                            Row(
                              children: [
                                Container(
                                  height: MySize.getHeight(48),
                                  width: MySize.getWidth(55),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(MySize.size10!),
                                      bottomLeft:
                                          Radius.circular(MySize.size10!),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "+91",
                                    style: TextStyle(),
                                  ),
                                ),
                                SizedBox(width: MySize.getWidth(1)),
                                InkWell(
                                  child: Container(
                                    width: MySize.getWidth(263),
                                    height: MySize.getHeight(48),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                MySize.getHeight(10)),
                                            bottomRight: Radius.circular(
                                                MySize.getHeight(10)))),
                                    child: getTextField(
                                        readOnly: true,
                                        hintText: "Mobile number",
                                        textInputType: TextInputType.number,
                                        size: MySize.getHeight(48),
                                        textEditingController:
                                            controller.mobileController),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      SizedBox(
                          height: MySize.getHeight(
                              (controller.isPatient.value) ? 65 : 170)),
                      InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (controller.isPatient.value) {
                              showPopUp(
                                  context: context, controller: controller);
                            } else {
                              controller.callCreateAccountApi(context: context);
                            }
                          },
                          child: getButton(
                              text: "Next", textColor: appTheme.primaryTheme)),
                      SizedBox(height: MySize.getHeight(25)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  showPopUp(
      {required BuildContext context,
      required CreateAccountController controller}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: appTheme.backgroundTheme,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Once enrolled as a patient, you will not be able to change the role."),
                  Spacing.height(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: getButton(
                          text: "Cancel",
                          height: 40,
                          width: 100,
                          textSize: 14,
                          textColor: Colors.black,
                        ),
                      ),
                      Spacing.width(20),
                      InkWell(
                        onTap: () {
                          Get.back();
                          controller.callCreateAccountApi(context: context);
                        },
                        child: getButton(
                          text: "OK",
                          height: 40,
                          width: 100,
                          textSize: 14,
                          textColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Card getCard(
      {required String image,
      required String text,
      bool isSelected = false,
      bool isGreyOut = false}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySize.size10!)),
      child: Container(
        height: MySize.getHeight(74),
        width: MySize.getWidth(96.2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MySize.size10!),
          color: (isGreyOut) ? Colors.white10 : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image,
                color: (isGreyOut)
                    ? appTheme.iconColor.withOpacity(0.2)
                    : (isSelected)
                        ? appTheme.primaryTheme
                        : appTheme.iconColor,
                width: MySize.getWidth(25),
                height: MySize.getHeight(20)),
            SizedBox(height: MySize.getHeight(7)),
            Text(
              text,
              style: TextStyle(
                  color: (isGreyOut)
                      ? appTheme.iconColor.withOpacity(0.2)
                      : (isSelected)
                          ? appTheme.primaryTheme
                          : appTheme.iconColor,
                  fontWeight: FontWeight.w400,
                  fontSize: MySize.getHeight(16)),
            ),
          ],
        ),
      ),
    );
  }
}
