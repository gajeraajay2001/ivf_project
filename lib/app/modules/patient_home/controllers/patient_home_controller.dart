import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../models/patient_my_schedule_model.dart';
import '../../../models/patient_profile_model.dart';
import '../../../utilities/progress_dialog_utils.dart';

class PatientHomeController extends GetxController {
  RxBool hasData = false.obs;
  DateTime msDate = DateTime.now();
  RxBool profileCheck = false.obs;
  RxList<EggRetreivalDataModel> eggRetrivalDataList =
      RxList<EggRetreivalDataModel>([]);
  @override
  void onInit() {
    getProfileData(context: Get.context!);

    super.onInit();
  }

  getProfileData({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    hasData.value = false;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.profileCheckApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getPatientMySchedule(context: Get.context!);
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          if (!isNullEmptyOrFalse(response["name"])) {
            box.write(ArgumentConstant.patientName, response["name"]);
          }
          PatientProfileModel res = PatientProfileModel.fromJson(response);

          if (res.isProfileComplete == false) {
            if (!isNullEmptyOrFalse(res.isUpdateProfileSkipped)) {
              if (res.isUpdateProfileSkipped == false) {
                if (!isNullEmptyOrFalse(res.daysSinceLastUpdate)) {
                  if (res.daysSinceLastUpdate! > 7) {
                    profileCheck.value = true;
                  }
                }
              }
            }
          }

          if (!isNullEmptyOrFalse(res.msCycleStartDate)) {
            msDate = DateFormat("dd MMMM yyyy").parse(res.msCycleStartDate!);
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

  skipProfileUpdate({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    app.resolve<CustomDialogs>().showCircularDialog(context);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.skipProfileUpdate,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          profileCheck.value = false;
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  getPatientMySchedule({required BuildContext context}) {
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientMyScheduleApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          PatientMyScheduleModel res =
              PatientMyScheduleModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patientProcedure)) {
            String procedureName = "";
            if (!isNullEmptyOrFalse(res.patientProcedure!.patientName)) {
              procedureName = res.patientProcedure!.patientName!;
            }
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((detailElement) {
                if (!isNullEmptyOrFalse(detailElement.events)) {
                  detailElement.events!.forEach((eventElement) {
                    if (eventElement.eventDbId == "624420e970c14f56956f3d1d") {
                      DateTime now = DateTime.now();
                      if (!isNullEmptyOrFalse(detailElement.dateTime)) {
                        if (detailElement.dateTime!
                                .isAfter(now.subtract(Duration(days: 1))) &&
                            detailElement.dateTime!
                                .isBefore(now.add(Duration(days: 6)))) {
                          // eggRetrivalDataList.add(
                          //   EggRetreivalDataModel(
                          //     dateTime: detailElement.dateTime!,
                          //     procedureName: procedureName,
                          //   ),
                          // );
                          eggRetrivalDataList.refresh();
                        }
                      }
                    }
                  });
                }
              });
            }
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasData.value = true;
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

class EggRetreivalDataModel {
  String? procedureName;
  DateTime? dateTime;
  EggRetreivalDataModel({
    this.dateTime,
    this.procedureName,
  });
}
