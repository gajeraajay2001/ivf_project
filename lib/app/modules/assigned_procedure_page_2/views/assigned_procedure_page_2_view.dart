import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/color_constant.dart';
import '../controllers/assigned_procedure_page_2_controller.dart';

class AssignedProcedurePage2View
    extends GetWidget<AssignedProcedurePage2Controller> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.backgroundTheme,
        body: Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: MySize.getHeight(27)),
                        decoration: BoxDecoration(
                            color: ColorConstant.red50,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(MySize.getHeight(50)),
                                bottomRight:
                                    Radius.circular(MySize.getHeight(50)))),
                        child: Column(
                          children: [
                            SizedBox(height: MySize.getHeight(20)),
                            Row(
                              children: [
                                SizedBox(width: MySize.getWidth(17)),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black,
                                      size: MySize.getHeight(25)),
                                ),
                                SizedBox(width: MySize.getWidth(21)),
                                Text(
                                  "Add Team details",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: MySize.getHeight(18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MySize.getHeight(30)),
                            Center(
                              child: Container(
                                height: MySize.getHeight(48),
                                width: MySize.getWidth(48),
                                decoration: BoxDecoration(
                                  color: Color(0xffA76488),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  (!isNullEmptyOrFalse(controller.patientName))
                                      ? (controller.patientName.length == 1)
                                          ? controller.patientName.toUpperCase()
                                          : (controller.patientName.length >= 2)
                                              ? "${controller.patientName[0].toUpperCase()}${controller.patientName[1].toUpperCase()}"
                                              : "gkg"
                                      : "gsg",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.getHeight(16)),
                                ),
                              ),
                            ),
                            SizedBox(height: MySize.getHeight(12)),
                            Center(
                                child: Text(
                              controller.patientName,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: MySize.getHeight(16),
                              ),
                            )),
                            Center(
                                child: Text(
                              "26 Yrs •  ${controller.patientProcedureName}",
                              style: TextStyle(fontSize: MySize.getHeight(15)),
                            )),
                            SizedBox(height: MySize.getHeight(30)),
                            Center(
                              child: Container(
                                  width: MySize.getWidth(281),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "LMP",
                                        style: TextStyle(
                                            color: appTheme.textColor),
                                      ),
                                      Text(
                                        "Procedure",
                                        style: TextStyle(
                                            color: appTheme.textColor),
                                      ),
                                      Text(
                                        "Team",
                                        style: TextStyle(
                                            color: appTheme.primaryTheme),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: MySize.getHeight(16)),
                            Center(
                                child: Image(
                              image: AssetImage("assets/Track003.png"),
                              width: MySize.getWidth(281),
                            )),
                            SizedBox(height: MySize.getHeight(28)),
                          ],
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(40)),
                      Container(
                        height: MySize.getHeight(250),
                        alignment: Alignment.center,
                        child: Text(
                          "Page Under Development.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(17)),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: MySize.getWidth(30)),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Team (Co-ordinator)",
                      //         style: TextStyle(
                      //           fontSize: MySize.getHeight(17),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(10)),
                      //       InkWell(
                      //         onTap: () async {
                      //           FocusScope.of(context).unfocus();
                      //           Get.toNamed(Routes.CONTACT_SCREEN,
                      //               arguments: {
                      //                 ArgumentConstant.fromAssignedProcedure:
                      //                     true,
                      //                 ArgumentConstant.isForAddTeam: true,
                      //                 ArgumentConstant.isForAddAgent: false,
                      //                 ArgumentConstant.isForAddEmbryologist:
                      //                     false,
                      //                 ArgumentConstant.isForAddCoPatient:
                      //                     false,
                      //               });
                      //         },
                      //         child: (!isNullEmptyOrFalse(
                      //                 controller.teamContactController.value))
                      //             ? Container(
                      //                 height: MySize.getHeight(48),
                      //                 width: MySize.screenWidth,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(
                      //                       MySize.getHeight(10)),
                      //                 ),
                      //                 alignment: Alignment.centerLeft,
                      //                 padding: EdgeInsets.only(
                      //                     left: MySize.getWidth(20)),
                      //                 child: Text(
                      //                   controller
                      //                       .teamContactController.value,
                      //                   style: TextStyle(
                      //                       fontSize: MySize.getHeight(15)),
                      //                 ),
                      //               )
                      //             : Container(
                      //                 child: SvgPicture.asset(
                      //                   "assets/add_Team.svg",
                      //                 ),
                      //               ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(22)),
                      //       Text(
                      //         "Agent",
                      //         style: TextStyle(
                      //           fontSize: MySize.getHeight(17),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(10)),
                      //       InkWell(
                      //         onTap: () {
                      //           FocusScope.of(context).unfocus();
                      //           Get.toNamed(Routes.CONTACT_SCREEN,
                      //               arguments: {
                      //                 ArgumentConstant.fromAssignedProcedure:
                      //                     true,
                      //                 ArgumentConstant.isForAddTeam: false,
                      //                 ArgumentConstant.isForAddAgent: true,
                      //                 ArgumentConstant.isForAddEmbryologist:
                      //                     false,
                      //                 ArgumentConstant.isForAddCoPatient:
                      //                     false,
                      //               });
                      //         },
                      //         child: (!isNullEmptyOrFalse(controller
                      //                 .agentContactController.value))
                      //             ? Container(
                      //                 height: MySize.getHeight(48),
                      //                 width: MySize.screenWidth,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(
                      //                       MySize.getHeight(10)),
                      //                 ),
                      //                 alignment: Alignment.centerLeft,
                      //                 padding: EdgeInsets.only(
                      //                     left: MySize.getWidth(20)),
                      //                 child: Text(
                      //                   controller
                      //                       .agentContactController.value,
                      //                   style: TextStyle(
                      //                       fontSize: MySize.getHeight(15)),
                      //                 ),
                      //               )
                      //             : Container(
                      //                 child: SvgPicture.asset(
                      //                   "assets/add_Agent.svg",
                      //                 ),
                      //               ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(22)),
                      //       Text(
                      //         "Radiologist",
                      //         style: TextStyle(
                      //           fontSize: MySize.getHeight(17),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(10)),
                      //       getTextField(
                      //         borderColor: appTheme.primaryTheme,
                      //         prefixIcon: Container(
                      //           height: MySize.getHeight(18),
                      //           width: MySize.getWidth(18),
                      //           alignment: Alignment.center,
                      //           child: SvgPicture.asset(
                      //             "assets/user001.svg",
                      //           ),
                      //         ),
                      //         hintText: "Sai Dharam Tej",
                      //         suffixIcon: Container(
                      //           height: MySize.getHeight(18),
                      //           width: MySize.getWidth(18),
                      //           alignment: Alignment.center,
                      //           child: SvgPicture.asset(
                      //             "assets/edit_icon.svg",
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(22)),
                      //       Text(
                      //         "Embryologist",
                      //         style: TextStyle(
                      //           fontSize: MySize.getHeight(17),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(10)),
                      //       InkWell(
                      //         onTap: () {
                      //           FocusScope.of(context).unfocus();
                      //           Get.toNamed(Routes.CONTACT_SCREEN,
                      //               arguments: {
                      //                 ArgumentConstant.fromAssignedProcedure:
                      //                     true,
                      //                 ArgumentConstant.isForAddTeam: false,
                      //                 ArgumentConstant.isForAddAgent: false,
                      //                 ArgumentConstant.isForAddEmbryologist:
                      //                     true,
                      //                 ArgumentConstant.isForAddCoPatient:
                      //                     false,
                      //               });
                      //         },
                      //         child: (!isNullEmptyOrFalse(controller
                      //                 .embryologistContactController.value))
                      //             ? Container(
                      //                 height: MySize.getHeight(48),
                      //                 width: MySize.screenWidth,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(
                      //                       MySize.getHeight(10)),
                      //                 ),
                      //                 alignment: Alignment.centerLeft,
                      //                 padding: EdgeInsets.only(
                      //                     left: MySize.getWidth(20)),
                      //                 child: Text(
                      //                   controller
                      //                       .embryologistContactController
                      //                       .value,
                      //                   style: TextStyle(
                      //                       fontSize: MySize.getHeight(15)),
                      //                 ),
                      //               )
                      //             : Container(
                      //                 child: SvgPicture.asset(
                      //                   "assets/add_Agent.svg",
                      //                 ),
                      //               ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(22)),
                      //       Text(
                      //         "Co-Patient Name",
                      //         style: TextStyle(
                      //           fontSize: MySize.getHeight(17),
                      //         ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(10)),
                      //       InkWell(
                      //         onTap: () {
                      //           FocusScope.of(context).unfocus();
                      //           Get.toNamed(Routes.CONTACT_SCREEN,
                      //               arguments: {
                      //                 ArgumentConstant.fromAssignedProcedure:
                      //                     true,
                      //                 ArgumentConstant.isForAddTeam: false,
                      //                 ArgumentConstant.isForAddAgent: false,
                      //                 ArgumentConstant.isForAddEmbryologist:
                      //                     false,
                      //                 ArgumentConstant.isForAddCoPatient:
                      //                     true,
                      //               });
                      //         },
                      //         child: (!isNullEmptyOrFalse(controller
                      //                 .coPatientContactController.value))
                      //             ? Container(
                      //                 height: MySize.getHeight(48),
                      //                 width: MySize.screenWidth,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(
                      //                       MySize.getHeight(10)),
                      //                 ),
                      //                 alignment: Alignment.centerLeft,
                      //                 padding: EdgeInsets.only(
                      //                     left: MySize.getWidth(20)),
                      //                 child: Text(
                      //                   controller
                      //                       .coPatientContactController.value,
                      //                   style: TextStyle(
                      //                       fontSize: MySize.getHeight(15)),
                      //                 ),
                      //               )
                      //             : Container(
                      //                 child: SvgPicture.asset(
                      //                   "assets/co_Patient.svg",
                      //                 ),
                      //               ),
                      //       ),
                      //       SizedBox(height: MySize.getHeight(20)),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (box.read(ArgumentConstant.tourStep2Started)) {
                    box.write(ArgumentConstant.tourStep2Completed, true);
                    box.write(ArgumentConstant.tourStep2Started, false);
                  }
                  Get.offAllNamed(Routes.HOME_SCREEN, arguments: {
                    ArgumentConstant.isNavigateToPatientsScreen: true,
                    ArgumentConstant.addedPatientProcedureDbId:
                        controller.addedPatientProcedureDbId,
                    ArgumentConstant.addedPatientDbId:
                        controller.addedPatientDbId,
                    ArgumentConstant.procedureDbId: controller.procedureDbId,
                  });
                },
                child: getContainerButton(
                    height: 60,
                    width: 328,
                    title: "Submit",
                    marginForBottom: MySize.getHeight(15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
