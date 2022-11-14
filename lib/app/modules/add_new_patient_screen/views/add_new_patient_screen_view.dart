import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart'
    hide BoxDecoration, BoxShadow;
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../controllers/add_new_patient_screen_controller.dart';

class AddNewPatientScreenView extends GetWidget<AddNewPatientScreenController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.backgroundTheme,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(17)),
            alignment: Alignment.center,
            child: (controller.hasData.isFalse)
                ? Center(
                    child:
                        CircularProgressIndicator(color: appTheme.primaryTheme))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MySize.getHeight(40)),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      size: MySize.getHeight(30)),
                                ),
                                SizedBox(width: MySize.getWidth(16)),
                                Text(
                                  "Add New Patient",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.getHeight(18)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(37)),
                          Text(
                            "Patient Full name",
                            style: TextStyle(
                                color: Color(0xffA66589),
                                fontSize: MySize.getHeight(15)),
                          ),
                          SizedBox(height: MySize.getHeight(8)),
                          Container(
                            height: MySize.getHeight(48),
                            width: MySize.getWidth(320),
                            child: getTextField(
                              hintText: "Enter Full Name",
                              textEditingController:
                                  controller.fullNameController,
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(20)),
                          Text(
                            "Mobile number",
                            style: TextStyle(
                                color: Color(0xffA66589),
                                fontSize: MySize.getHeight(15)),
                          ),
                          SizedBox(height: MySize.getHeight(8)),
                          Container(
                            height: MySize.getHeight(48),
                            width: MySize.getWidth(320),
                            child: getTextField(
                              textInputType: TextInputType.number,
                              hintText: "Enter Mobile Number",
                              textEditingController:
                                  controller.mobileNumberController,
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(20)),
                          Text(
                            "Procedure to Assign",
                            style: TextStyle(
                                color: Color(0xffA66589),
                                fontSize: MySize.getHeight(15)),
                          ),
                          SizedBox(height: MySize.getHeight(8)),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MySize.getHeight(5),
                                right: MySize.getHeight(5),
                                bottom: MySize.getHeight(10)),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: MySize.getWidth(15),
                              runSpacing: MySize.getHeight(24),
                              children: List.generate(
                                  controller.procedureTypesList.length,
                                  (index) {
                                return InkWell(
                                  onTap: () {
                                    controller.procedureTypesList
                                        .forEach((element) {
                                      element.isActive!.value = false;
                                    });
                                    controller.procedureTypesList[index]
                                        .isActive!.value = true;
                                    controller.isProcedureSelected.value = true;
                                  },
                                  child: Container(
                                    height: MySize.getHeight(51),
                                    width: MySize.getWidth(150),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: (controller
                                                .procedureTypesList[index]
                                                .isActive!
                                                .isTrue)
                                            ? Colors.white
                                            : appTheme.backgroundTheme,
                                        borderRadius: BorderRadius.circular(
                                          MySize.getHeight(15),
                                        ),
                                        boxShadow: (controller
                                                .procedureTypesList[index]
                                                .isActive!
                                                .isTrue)
                                            ? [
                                                BoxShadow(
                                                  offset: Offset(-5, -5),
                                                  blurRadius: 5,
                                                  color: Colors.white,
                                                  inset: true,
                                                ),
                                                BoxShadow(
                                                  offset: Offset(5, 5),
                                                  blurRadius: 5,
                                                  color: Color(0xFFA7A9AF)
                                                      .withOpacity(0.7),
                                                  inset: true,
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  offset: Offset(4, 4),
                                                  color: Color(0xffAEAEC0)
                                                      .withOpacity(0.4),
                                                  blurRadius: MySize.size3!,
                                                  spreadRadius: MySize.size2!,
                                                ),
                                                BoxShadow(
                                                  offset: Offset(-2.0, -2.0),
                                                  color: Color(0xffFFFFFF)
                                                      .withOpacity(0.6),
                                                  blurRadius: MySize.size2!,
                                                  spreadRadius: MySize.size2!,
                                                ),
                                              ]),
                                    child: Text(
                                      controller
                                          .procedureTypesList[index].name!,
                                      style: TextStyle(
                                          fontWeight: (controller
                                                  .procedureTypesList[index]
                                                  .isActive!
                                                  .isTrue)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: (controller
                                                  .procedureTypesList[index]
                                                  .isActive!
                                                  .isTrue)
                                              ? appTheme.primaryTheme
                                              : Colors.black),
                                    ),
                                  ),
                                );
                                // return Neumorphic(
                                //   style: NeumorphicStyle(
                                //       color: (controller
                                //               .procedureTypesList[index].isActive!.value)
                                //           ? Color(0xffFFF6FB)
                                //           : appTheme.backgroundTheme,
                                //       shadowLightColorEmboss: (controller
                                //               .procedureTypesList[index].isActive!.value)
                                //           ? Colors.white
                                //           : appTheme.backgroundTheme,
                                //       depth: (controller
                                //               .procedureTypesList[index].isActive!.value)
                                //           ? -10
                                //           : 10),
                                //   child: Container(
                                //     height: MySize.getHeight(51),
                                //     width: MySize.getWidth(150),
                                //     alignment: Alignment.center,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(
                                //             MySize.getHeight(10))),
                                //     child:
                                //         Text(controller.procedureTypesList[index].title!),
                                //   ),
                                // );
                              }),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isProcedureSelected.isTrue) {
                            if (isNullEmptyOrFalse(
                                controller.fullNameController.text)) {
                              getSnackBar(
                                  context: context, text: "Please enter name.");
                            } else if (isNullEmptyOrFalse(
                                controller.mobileNumberController.text)) {
                              getSnackBar(
                                  context: context,
                                  text: "Please enter mobile number.");
                            } else {
                              controller.callAddPatientsApi(context: context);
                            }
                          } else {
                            getGetXSnackBar(
                                title: "Error",
                                msg: "Please select procedure first.");
                          }
                        },
                        child: Container(
                          width: MySize.getWidth(332),
                          height: MySize.getHeight(56),
                          margin: EdgeInsets.only(bottom: MySize.getHeight(10)),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(MySize.getHeight(15)),
                            color: (controller.isProcedureSelected.value)
                                ? appTheme.primaryTheme
                                : appTheme.primaryTheme.withOpacity(0.6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Create and Invite Patient",
                            style: TextStyle(
                                color: (controller.isProcedureSelected.value)
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                fontSize: MySize.getHeight(18)),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
