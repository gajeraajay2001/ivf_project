import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../utilities/color_constant.dart';
import '../../../utilities/text_field.dart';
import '../controllers/doctor_my_profile_controller.dart';

class DoctorMyProfileView extends GetWidget<DoctorMyProfileController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          backgroundColor: ColorConstant.red50,
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: Colors.black)),
            backgroundColor: ColorConstant.red50,
            title: Text(
              "My Profile",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
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
                            controller: controller.licenceIdController,
                            hint: "Eg. 98734879",
                            title: "AIIMS Isued Licence ID"),
                        getColumn(
                            controller: controller.clinicNameController,
                            hint: "Eg. Sarayu Fertility Clinic",
                            title: "Clinic Name"),
                        getColumn(
                            controller: controller.address1Controller,
                            hint: "Eg. 202, Level 4, Miniar Arcade",
                            title: "Address Line 1"),
                        getColumn(
                            controller: controller.address2Controller,
                            hint: "Eg. Street 4, Road 3, Tilak Nagar",
                            title: "Address Line 2"),
                        getColumn(
                            controller: controller.localityController,
                            hint: "Eg. Andheri West",
                            title: "Locality"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: MySize.getWidth(20)),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xff777777),
                                      fontSize: MySize.getHeight(18)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
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
          ),
        );
      }),
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
