import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../controllers/doctor_profile_controller.dart';

class DoctorProfileView extends GetWidget<DoctorProfileController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Container(
            height: MySize.safeHeight,
            width: MySize.screenWidth,
            color: appTheme.backgroundTheme,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MySize.getWidth(360),
                    height: MySize.getWidth(178),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.black12,
                          spreadRadius: MySize.getHeight(-5),
                          blurRadius: MySize.getHeight(10),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset("assets/Frame 29404.svg",
                        fit: BoxFit.cover),
                  ),
                  SizedBox(height: MySize.size25),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Highest Educational Qualification",
                            style: TextStyle(fontSize: MySize.getHeight(16))),
                        SizedBox(height: MySize.size8),
                        PopupMenuButton(
                          itemBuilder: (context) => List.generate(
                              controller.qualificationList.length, (index) {
                            return PopupMenuItem(
                              child: SizedBox(
                                  width: MySize.screenWidth,
                                  child: Text(
                                      controller.qualificationList[index])),
                              enabled: true,
                              onTap: () {
                                controller.qualificationController.value.text =
                                    controller.qualificationList[index];
                                controller.qualificationController.refresh();
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
                                Text(controller
                                    .qualificationController.value.text),
                                Icon(Icons.expand_more,
                                    size: MySize.getHeight(35),
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size28),
                        getColumn(
                            controller: controller.clinicNameController,
                            hint: "Eg. Sarayu Fertility Clinic",
                            title: "Clinic Name"),
                        getColumn(
                            controller: controller.licenceIdController,
                            hint: "Eg. 98734879",
                            title: "AIIMS Isued Licence ID"),
                        // getColumn(
                        //     controller: controller.address1Controller,
                        //     hint: "Eg. 202, Level 4, Miniar Arcade",
                        //     title: "Address Line 1"),
                        // getColumn(
                        //     controller: controller.address2Controller,
                        //     hint: "Eg. Street 4, Road 3, Tilak Nagar",
                        //     title: "Address Line 2"),
                        // getColumn(
                        //     controller: controller.localityController,
                        //     hint: "Eg. Andheri West",
                        //     title: "Locality"),
                        Text("City",
                            style: TextStyle(fontSize: MySize.getHeight(16))),
                        SizedBox(height: MySize.size8),
                        PopupMenuButton(
                          itemBuilder: (context) => List.generate(
                              controller.cityList.length, (index) {
                            return PopupMenuItem(
                              child: SizedBox(
                                  width: MySize.screenWidth,
                                  child: Text(controller.cityList[index])),
                              enabled: true,
                              onTap: () {
                                controller.cityController.value.text =
                                    controller.cityList[index];
                                controller.cityController.refresh();
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
                                Text(controller.cityController.value.text),
                                Icon(Icons.expand_more,
                                    size: MySize.getHeight(35),
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size28),
                        // getColumn(
                        //     controller: controller.zipCodeController,
                        //     hint: "400901",
                        //     title: "Zip Code"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.offAllNamed(Routes.HOME_SCREEN);
                              },
                              child: Text(
                                "I’ll do it Later",
                                style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: MySize.getHeight(18)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAllNamed(Routes.HOME_SCREEN);
                              },
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    color: appTheme.primaryTheme,
                                    shape: NeumorphicShape.flat,
                                    depth: 20,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(
                                            MySize.getHeight(100)))),
                                child: Container(
                                  height: MySize.getHeight(55),
                                  width: MySize.getWidth(156),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MySize.size100!)),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MySize.size20!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.size33),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Column getColumn(
      {required TextEditingController controller,
      required String hint,
      required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: MySize.getHeight(16)),
        ),
        SizedBox(height: MySize.size8),
        getTextField(textEditingController: controller, hintText: hint),
        SizedBox(height: MySize.size28),
      ],
    );
  }
}
