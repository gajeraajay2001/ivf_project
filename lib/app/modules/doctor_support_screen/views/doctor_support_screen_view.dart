import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/utilities/color_constant.dart';

import '../../../constants/sizeConstant.dart';
import '../controllers/doctor_support_screen_controller.dart';

class DoctorSupportScreenView extends GetWidget<DoctorSupportScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.red50,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),
          backgroundColor: ColorConstant.red50,
          title: Text(
            "Support",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Spacing.height(20),
            Expanded(
              child: ListView.separated(
                  itemCount: controller.data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: MySize.getHeight(10),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: MySize.getHeight(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MySize.getWidth(20),
                              ),
                              child: Text(
                                controller.data[index].megaTitle!.toUpperCase(),
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                            Spacing.height(10),
                            Container(
                              child: Column(
                                children: List.generate(
                                    controller.data[index].megaContent!.length,
                                    (ind) {
                                  return Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 2,
                                      color: Color(0xffFFF4FB),
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: MySize.getHeight(5)),
                                    padding: EdgeInsets.only(
                                        top: MySize.getHeight(7),
                                        left: MySize.getWidth(10)),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: MySize.getHeight(10),
                                          bottom: MySize.getHeight(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.data[index]
                                                  .megaContent![ind].isExpanded!
                                                  .toggle();
                                            },
                                            child: Row(children: [
                                              SizedBox(
                                                width: MySize.getWidth(310),
                                                child: Text(
                                                  controller.data[index]
                                                      .megaContent![ind].title
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Icon((controller
                                                      .data[index]
                                                      .megaContent![ind]
                                                      .isExpanded!
                                                      .isTrue)
                                                  ? Icons.expand_less
                                                  : Icons.expand_more),
                                            ]),
                                          ),
                                          if (controller
                                              .data[index]
                                              .megaContent![ind]
                                              .isExpanded!
                                              .isTrue)
                                            Container(
                                              width: MySize.getWidth(300),
                                              padding: EdgeInsets.only(
                                                top: MySize.getHeight(10),
                                              ),
                                              child: Text(
                                                  "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future"),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
