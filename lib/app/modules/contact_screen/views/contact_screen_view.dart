import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/spinkit_widget.dart';
import '../../create_procedure_customise/views/create_procedure_customise_view.dart';
import '../controllers/contact_screen_controller.dart';

class ContactScreenView extends GetWidget<ContactScreenController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactScreenController>(
      init: ContactScreenController(),
      builder: (controller) {
        return ShowCaseWidget(
          disableBarrierInteraction: true,
          onFinish: () {
            controller.tourViewed.value = true;
            controller.tourViewed.refresh();
          },
          builder: Builder(
            builder: (context) {
              if (box.read(ArgumentConstant.tourStep2Started) &&
                  controller.tourViewed.isFalse) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Future.delayed(Duration(milliseconds: 300), () {
                    ShowCaseWidget.of(context).startShowCase(
                        [controller.patientContactShowCaseKey.value]);
                  }),
                );
              }
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Obx(() {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: MySize.getWidth(0)),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: MySize.getHeight(41)),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(width: MySize.getWidth(10)),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      size: MySize.getHeight(30)),
                                ),
                                SizedBox(width: MySize.getWidth(16)),
                                getSearchBar(
                                    context: context, controller: controller),
                              ],
                            ),
                          ),
                          SizedBox(height: MySize.getHeight(41)),
                          if (!controller.isForAssignedProcedure)
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.ADD_NEW_PATIENT_SCREEN);
                              },
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    color: Color(0xffFFE8F5), depth: 7),
                                child: Container(
                                  width: MySize.getWidth(340),
                                  height: MySize.getHeight(52),
                                  child: Row(
                                    children: [
                                      SizedBox(width: MySize.getWidth(18)),
                                      SvgPicture.asset(
                                        "assets/add_user01.svg",
                                        height: MySize.getHeight(20),
                                        width: MySize.getWidth(20),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: MySize.getWidth(18)),
                                      Text(
                                        "Create New",
                                        style: TextStyle(
                                            color: appTheme.primaryTheme,
                                            fontSize: MySize.getHeight(16),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: MySize.getHeight(18)),
                          Expanded(
                            child: (controller.hasData.isFalse)
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: appTheme.primaryTheme),
                                  )
                                : (isNullEmptyOrFalse(controller.contacts))
                                    ? Center(child: Text("No Contacts Found."))
                                    : ListView.separated(
                                        itemBuilder: (context, index) {
                                          if (box.read(ArgumentConstant
                                                  .tourStep2Started) &&
                                              index == 0) {
                                            return getFirstContactCardForTour(
                                                index: index,
                                                controller: controller,
                                                context: context);
                                          } else if (!isNullEmptyOrFalse(
                                              controller
                                                  .contacts[index].phones)) {
                                            return getcontactsCardWidget(
                                                context: context,
                                                controller: controller,
                                                index: index);
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: MySize.getHeight(
                                                isNullEmptyOrFalse(controller
                                                        .contacts[index].phones)
                                                    ? 0
                                                    : 18),
                                          );
                                        },
                                        itemCount: controller.contacts.length,
                                      ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        );
      },
    );
  }

  //get Contact Cards

  Widget getFirstContactCardForTour(
      {required BuildContext context,
      required ContactScreenController controller,
      required int index}) {
    String name = (!isNullEmptyOrFalse(box.read(ArgumentConstant.doctorName)))
        ? "${box.read(ArgumentConstant.doctorName)}(Sample Patient)"
        : "(Sample Patient)";
    String number =
        (!isNullEmptyOrFalse(box.read(ArgumentConstant.doctorMobileNumber)))
            ? "${box.read(ArgumentConstant.doctorMobileNumber)}"
            : "";
    return Showcase.withWidget(
      key: controller.patientContactShowCaseKey.value,
      height: MySize.getHeight(40),
      width: MySize.getWidth(200),
      onTargetClick: () {
        controller.tourViewed.value = true;
        ShowCaseWidget.of(context).next();
        Get.toNamed(Routes.ADD_NEW_PATIENT_SCREEN, arguments: {
          ArgumentConstant.addedPatientName: name,
          ArgumentConstant.addedPatientNumber: number
        });
      },
      container: Stack(
        children: [
          Positioned(
            left: MySize.getWidth(20),
            child: CustomPaint(
              painter: Arrow(
                strokeColor: Colors.white,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
                isUpArrow: true,
              ),
              child: SizedBox(
                height: MySize.getHeight(9),
                width: MySize.getWidth(18),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MySize.getHeight(9)),
            padding: EdgeInsets.symmetric(
                horizontal: MySize.getWidth(20), vertical: MySize.getHeight(5)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(MySize.getHeight(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MySize.getWidth(300),
                  child: Text(
                    "Patients can be selected from your contact list or you can add patients manually by “Create new”.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Spacing.height(5),
                InkWell(
                  onTap: () {
                    controller.tourViewed.value = true;
                    ShowCaseWidget.of(context).next();
                    Get.toNamed(Routes.ADD_NEW_PATIENT_SCREEN, arguments: {
                      ArgumentConstant.addedPatientName: name,
                      ArgumentConstant.addedPatientNumber: number
                    });
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: appTheme.primaryTheme),
                  ),
                ),
                Spacing.height(5),
              ],
            ),
          ),
        ],
      ),
      overlayPadding: EdgeInsets.symmetric(
          vertical: MySize.getHeight(10), horizontal: MySize.getWidth(10)),
      overlayColor: Colors.transparent,
      overlayOpacity: 0.2,
      showcaseBackgroundColor: Colors.white,
      child: Center(
        child: Neumorphic(
          style: NeumorphicStyle(
              color: Colors.white, shadowLightColorEmboss: Colors.black),
          margin: EdgeInsets.symmetric(horizontal: MySize.getWidth(10)),
          child: Container(
            height: MySize.getHeight(80),
            width: MySize.getWidth(380),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                SizedBox(width: MySize.getWidth(18)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10000),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: MySize.getHeight(40),
                    width: MySize.getWidth(40),
                    child: Image.asset("assets/user_image.png"),
                  ),
                ),
                SizedBox(width: MySize.getWidth(18)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(15)),
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(3)),
                      Text(
                        number,
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                            fontSize: MySize.getHeight(12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getcontactsCardWidget(
      {required BuildContext context,
      required ContactScreenController controller,
      required int index}) {
    return Center(
      child: InkWell(
        onTap: () {
          if (controller.isForAssignedProcedure) {
            if (controller.isForAddTeam) {
              controller.assignProcedureScreenController!.teamContact =
                  controller.contacts[index].obs;
              controller.assignProcedureScreenController!.teamContactController
                  .value = controller.contacts[index].displayName ?? "";
            } else if (controller.isForAddAgent) {
              controller.assignProcedureScreenController!.agentContact =
                  controller.contacts[index].obs;
              controller.assignProcedureScreenController!.agentContactController
                  .value = controller.contacts[index].displayName ?? "";
            } else if (controller.isForAddEmbryologist) {
              controller.assignProcedureScreenController!.embryologistContact =
                  controller.contacts[index].obs;
              controller
                  .assignProcedureScreenController!
                  .embryologistContactController
                  .value = controller.contacts[index].displayName ?? "";
            } else if (controller.isForAddCoPatient) {
              controller.assignProcedureScreenController!.coPatientContact =
                  controller.contacts[index].obs;
              controller
                  .assignProcedureScreenController!
                  .coPatientContactController
                  .value = controller.contacts[index].displayName ?? "";
            }

            Get.back();
          } else {
            Get.toNamed(Routes.ADD_NEW_PATIENT_SCREEN, arguments: {
              ArgumentConstant.addedPatientName:
                  controller.contacts[index].displayName,
              ArgumentConstant.addedPatientNumber:
                  (isNullEmptyOrFalse(controller.contacts[index].phones))
                      ? ""
                      : controller.contacts[index].phones![0].value
            });
          }
        },
        child: Neumorphic(
          style: NeumorphicStyle(
              color: Colors.white, shadowLightColorEmboss: Colors.black),
          margin: EdgeInsets.symmetric(horizontal: MySize.getWidth(10)),
          child: Container(
            height: MySize.getHeight(80),
            width: MySize.getWidth(380),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                SizedBox(width: MySize.getWidth(18)),
                FutureBuilder(
                    future: controller.getAvatar(
                        contact: controller.contacts[index]),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(10000),
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: MySize.getHeight(40),
                                width: MySize.getWidth(40),
                                child: SpinKitCircle(
                                  size: MySize.getHeight(15),
                                  color: appTheme.primaryTheme,
                                )));
                      } else if (snap.hasData) {
                        Uint8List sna = snap.data as Uint8List;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10000),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            height: MySize.getHeight(40),
                            width: MySize.getWidth(40),
                            child: Image.memory(sna),
                          ),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10000),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: MySize.getHeight(40),
                          width: MySize.getWidth(40),
                          child: Image.asset("assets/user_image.png"),
                        ),
                      );
                    }),
                SizedBox(width: MySize.getWidth(18)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          (isNullEmptyOrFalse(
                                  controller.contacts[index].displayName))
                              ? "NA"
                              : controller.contacts[index].displayName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(15)),
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(3)),
                      Text(
                        (isNullEmptyOrFalse(controller.contacts[index].phones))
                            ? "NA"
                            : controller.contacts[index].phones![0].value
                                .toString(),
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                            fontSize: MySize.getHeight(12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBar(
      {required BuildContext context,
      required ContactScreenController controller}) {
    return GestureDetector(
      onTap: () {
        controller.isSearchActive.toggle();
      },
      child: (controller.isSearchActive.isTrue)
          ? Container(
              width: MySize.getWidth(280),
              height: MySize.getHeight(30),
              child: TextField(
                controller: controller.searchController,
                cursorColor: appTheme.primaryTheme,
                onChanged: (val) {
                  bool isNumber = val.isNum;
                  print("isNum := $isNumber");
                  controller.filterData(
                      text: val.toString().trim().toLowerCase(),
                      isNumber: isNumber);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: appTheme.primaryTheme),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: appTheme.primaryTheme),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: appTheme.primaryTheme),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: appTheme.primaryTheme),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.isSearchActive.value = false;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MySize.getHeight(5)),
                      child: Icon(
                        Icons.close,
                        color: appTheme.primaryTheme,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(
              "Add Patient from Contact list",
              style: TextStyle(
                  color: Color(0xff999999), fontSize: MySize.getHeight(18)),
            ),
    );
  }
}
