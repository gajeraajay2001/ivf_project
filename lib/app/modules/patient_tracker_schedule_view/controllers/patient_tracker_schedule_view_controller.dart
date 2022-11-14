import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/patient_tracker_procedure_model.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../main.dart';
import '../../patient_tracker_screen/controllers/patient_tracker_screen_controller.dart';

class PatientTrackerScheduleViewController extends GetxController {
  RxList<PatientTrackerMenuModel> patientTrackerMenuModel = [
    PatientTrackerMenuModel(isActive: false.obs, title: "Profile"),
    PatientTrackerMenuModel(isActive: true.obs, title: "Schedule"),
    PatientTrackerMenuModel(isActive: false.obs, title: "Reports"),
    PatientTrackerMenuModel(isActive: false.obs, title: "Contacts"),
  ].obs;
  RxBool hasData = false.obs;
  RxList<Detail> procedureDetailsList = RxList<Detail>([]);
  String patientProcedureDbId = "";
  String patientName = "";
  String patientAge = "0";
  String patientMobileNumber = "";
  String patientProcedureName = "";
  ItemScrollController itemScrollController = ItemScrollController();
  RxBool isTodayViewed = false.obs;
  @override
  void onInit() {
    if (!isNullEmptyOrFalse(Get.arguments)) {
      patientProcedureDbId =
          Get.arguments[ArgumentConstant.patientProcedureDbId];
      getProcedureDetails(context: Get.context!);
    }
    super.onInit();
  }

  getProcedureDetails({required BuildContext context}) {
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientProcedureApi +
          "?patient_procedure_db_id=$patientProcedureDbId",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        procedureDetailsList.clear();
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          PatientTrackerProcedureModel res =
              PatientTrackerProcedureModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patientProcedure)) {
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((element) {
                procedureDetailsList.add(element);
              });
            }
            if (!isNullEmptyOrFalse(res.patientProcedure!.patientName)) {
              patientName = res.patientProcedure!.patientName!;
            }
            if (!isNullEmptyOrFalse(res.patientProcedure!.age)) {
              patientAge = res.patientProcedure!.age!;
            }

            if (!isNullEmptyOrFalse(res.patientProcedure!.procedure)) {
              if (!isNullEmptyOrFalse(res.patientProcedure!.procedure!.name)) {
                patientProcedureName = res.patientProcedure!.procedure!.name!;
              }
            }
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  callAssignProcedureApi({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    dict["name"] = patientName;
    dict["mobile_number"] = patientMobileNumber;
    dict["country_code"] = "+91";
    dict["procedure_db_id"] = patientProcedureDbId;
    app.resolve<CustomDialogs>().showCircularDialog(context);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.addPatientApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          print(response);
          Get.dialog(
            Scaffold(
              backgroundColor: Colors.white.withOpacity(0.8),
              body: Center(
                child: Column(
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      "assets/check_icon.svg",
                      height: MySize.getHeight(64),
                      width: MySize.getWidth(64),
                    ),
                    Space.width(MySize.getHeight(20)),
                    Text(
                      "Patient Invited\nSuccessfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MySize.getHeight(18),
                          fontWeight: FontWeight.bold,
                          color: appTheme.primaryTheme),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            barrierDismissible: false,
          );
          Timer(
            Duration(milliseconds: 400),
            () => Get.offAndToNamed(Routes.ASSIGN_PROCEDURE_SCREEN, arguments: {
              ArgumentConstant.addedPatientName: patientName,
              ArgumentConstant.addedPatientProcedureName: patientProcedureName,
              ArgumentConstant.addedPatientDbId: response["user_detail"]["id"],
              ArgumentConstant.addedPatientProcedureDbId:
                  response["patient_procedure"]["id"]
            }),
          );
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class PatientTrackerMenuModel {
  String? title;
  RxBool? isActive;
  PatientTrackerMenuModel({this.title, this.isActive});
}
