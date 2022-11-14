import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

import '../controllers/patient_tracker_contacts_view_controller.dart';

class PatientTrackerContactsViewView
    extends GetWidget<PatientTrackerContactsViewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientTrackerContactsViewController>(
        init: PatientTrackerContactsViewController(),
        builder: (controller) {
          return Obx(() {
            return Scaffold(
              backgroundColor: appTheme.backgroundTheme,
              body: (controller.hasData.isFalse)
                  ? Center(
                      child: CircularProgressIndicator(
                          color: appTheme.primaryTheme),
                    )
                  : (isNullEmptyOrFalse(controller.userContactDataList))
                      ? Center(
                          child: Text("No Contacts Available"),
                        )
                      : Container(
                          child: Column(
                            children: [
                              Spacing.height(21),
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            shadowLightColorEmboss:
                                                Colors.white10,
                                            color: appTheme.backgroundTheme,
                                          ),
                                          child: Container(
                                            height: MySize.getHeight(80),
                                            width: MySize.getWidth(340),
                                            // padding: EdgeInsets.symmetric(
                                            //   horizontal: MySize.getWidth(17),
                                            //   vertical: MySize.getHeight(15),
                                            // ),
                                            child: ListTile(
                                              minLeadingWidth:
                                                  MySize.getWidth(30),
                                              leading: Container(
                                                child: Image.asset(
                                                    "assets/pic001.png"),
                                              ),
                                              title: Text(
                                                controller
                                                    .userContactDataList[index]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        MySize.getHeight(15),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                  (controller
                                                          .userContactDataList[
                                                              index]
                                                          .isPatient!)
                                                      ? "Patient"
                                                      : (controller
                                                              .userContactDataList[
                                                                  index]
                                                              .isDoctor!)
                                                          ? "Doctor"
                                                          : (controller
                                                                  .userContactDataList[
                                                                      index]
                                                                  .isAgent!)
                                                              ? "Agent"
                                                              : "",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MySize.getHeight(12),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              trailing: InkWell(
                                                onTap: () {
                                                  if (!isNullEmptyOrFalse(
                                                      controller
                                                          .userContactDataList[
                                                              index]
                                                          .mobileNo)) {
                                                    urlLauncher(
                                                        number: controller
                                                            .userContactDataList[
                                                                index]
                                                            .mobileNo!);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/call.svg"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Spacing.height(10);
                                    },
                                    itemCount:
                                        controller.userContactDataList.length),
                              ),
                            ],
                          ),
                        ),
            );
          });
        });
  }
}
