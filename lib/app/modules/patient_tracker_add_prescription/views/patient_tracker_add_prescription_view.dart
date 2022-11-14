import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/text_field.dart';

import '../../../constants/sizeConstant.dart';
import '../../../theme/app_style.dart';
import '../../../utilities/color_constant.dart';
import '../controllers/patient_tracker_add_prescription_controller.dart';

class PatientTrackerAddPrescriptionView
    extends GetView<PatientTrackerAddPrescriptionController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MySize.getHeight(90),
              decoration: BoxDecoration(
                color: ColorConstant.pink50A2,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
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
                                    "Add Medication",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.textStyleDMSansmedium16
                                        .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.getHeight(18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: MySize.getWidth(10)),
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xffFD7E5C),
                                      fontSize: MySize.getHeight(16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MySize.getHeight(35)),
                      Text(
                        "Upload Prescription",
                        style: TextStyle(
                            fontSize: MySize.getHeight(16),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: MySize.getHeight(10)),
                      Container(
                        height: MySize.getHeight(142),
                        width: MySize.getWidth(320),
                      ),
                      SizedBox(height: MySize.getHeight(28)),
                      Text(
                        "Extra Instructions",
                        style: TextStyle(
                            fontSize: MySize.getHeight(16),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: MySize.getHeight(3)),
                      getTextField(
                        maxLine: 5,
                        hintText: "Enter Notes",
                        textEditingController: controller.noteController,
                        borderColor: appTheme.primaryTheme.withOpacity(0.4),
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(height: MySize.getHeight(30)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Max 200 Characters",
                          style: TextStyle(
                              color: appTheme.primaryTheme.withOpacity(0.5)),
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(100)),
                      Center(
                        child: SizedBox(
                          height: MySize.getHeight(26),
                          width: MySize.getWidth(313),
                          child: Text(
                            "** This New Prescription will apply to Patient from Today in Patient’s Procedure. ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: MySize.getHeight(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(13)),
                      Center(
                        child: InkWell(
                          onTap: () {
                            openBottomSheetForUpload(context: context);
                          },
                          child: Container(
                            height: MySize.getHeight(62),
                            width: MySize.getWidth(320),
                            decoration: BoxDecoration(
                              color: appTheme.primaryTheme,
                              borderRadius: BorderRadius.circular(
                                MySize.getHeight(15),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Save Medication",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.getHeight(18)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(20)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openBottomSheetForUpload({required BuildContext context}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: appTheme.backgroundTheme,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MySize.getHeight(30)),
                topRight: Radius.circular(MySize.getHeight(30)))),
        builder: (context) {
          return Container(
            height: MySize.getHeight(203),
            width: MySize.getWidth(360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MySize.getHeight(35)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MySize.getHeight(40),
                            width: MySize.getWidth(40),
                            child: SvgPicture.asset(
                              "assets/folder_icon.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(7)),
                          Text(
                            "File Manager",
                            style: TextStyle(fontSize: MySize.getHeight(10)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MySize.getHeight(40),
                            width: MySize.getWidth(40),
                            child: SvgPicture.asset(
                              "assets/camera_icon.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(7)),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: MySize.getHeight(10)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MySize.getHeight(40),
                            width: MySize.getWidth(40),
                            child: SvgPicture.asset(
                              "assets/gallery_icon.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(7)),
                          Text(
                            "Gallery",
                            style: TextStyle(fontSize: MySize.getHeight(10)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.getHeight(40)),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: getButton(
                    text: "Cancel",
                    height: MySize.getHeight(39),
                    width: MySize.getWidth(233),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
