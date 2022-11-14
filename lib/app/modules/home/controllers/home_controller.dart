import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/get_tour_data_model.dart';
import 'package:ivf_project/app/models/patients_list_model.dart';
import 'package:ivf_project/app/models/profile_check_model.dart';
import 'package:ivf_project/main.dart';

import '../../../utilities/progress_dialog_utils.dart';

class HomeController extends GetxController {
  RxList<Patients> patientsList = RxList<Patients>([]);
  RxList<EggRetreivalDataModel> eggRetrivalDataList =
      RxList<EggRetreivalDataModel>([]);
  RxBool hasData = false.obs;
  RxBool profileCheck = false.obs;
  RxString doctorName = "".obs;
  Function? jumpPage;
  Tour tourData = Tour();
  RxInt tourCompleted = 0.obs;
  RxBool allTourStepsJustCompleted = false.obs;
  @override
  void onInit() {
    box.write(ArgumentConstant.tourStep1Started, false);
    box.write(ArgumentConstant.tourStep2Started, false);
    box.write(ArgumentConstant.tourStep3Started, false);
    allTourStepsJustCompleted.value =
        box.read(ArgumentConstant.allTourStepsJustCompleted);
    getTourStepData(context: Get.context!);
    super.onInit();
  }

  getTourStepData({required BuildContext context}) {
    hasData.value = false;
    tourCompleted.value = 0;
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getTourStepApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        callPatientsListAPi(context: context);
        if (response["status_code"] == 200 && response["response"] == true) {
          GetTourDataModel res = GetTourDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.tour)) {
            tourData = res.tour!;
            if (!isNullEmptyOrFalse(res.tour!.steps)) {
              res.tour!.steps!.forEach((element) {
                if (element.isCompleted!) {
                  tourCompleted.value++;
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
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  resetTourStepData({required BuildContext context}) {
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getTourStepApi,
      MethodType.Put,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          getTourStepData(context: context);
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

  callPatientsListAPi({required BuildContext context}) {
    hasData.value = false;
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientsListApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        getProfileCheck(context: Get.context!);
        if (response["status_code"] == 200 && response["response"] == true) {
          PatientsListModel res = PatientsListModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patients)) {
            res.patients!.forEach((patients) {
              if (!isNullEmptyOrFalse(patients.events)) {
                patients.events!.forEach((eventElement) {
                  DateTime now = DateTime.now();
                  if (!isNullEmptyOrFalse(eventElement.events)) {
                    eventElement.events!.forEach((element) {
                      if (element.eventDbId == "624420e970c14f56956f3d1d") {
                        if (eventElement.dateTime!
                                .isAfter(now.subtract(Duration(days: 1))) &&
                            eventElement.dateTime!
                                .isBefore(now.add(Duration(days: 6)))) {
                          patientsList.add(patients);

                          eggRetrivalDataList.add(EggRetreivalDataModel(
                              id: patients.patient!.id,
                              userDbId: patients.patient!.patient!.userDbId!,
                              dateTime: eventElement.dateTime!,
                              patientName: patients.patient!.patient!.name,
                              procedureName:
                                  patients.patient!.procedure!.name));
                        }
                      }
                    });
                  }
                });
              }
            });
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }

        if (!isNullEmptyOrFalse(patientsList)) {}
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

  getProfileCheck({required BuildContext context}) {
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
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          ProfileCheckModel res = ProfileCheckModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.mobileNumber)) {
            box.write(ArgumentConstant.doctorMobileNumber,
                res.mobileNumber.toString());
          }

          if (res.isProfileComplete == false) {
            if (!isNullEmptyOrFalse(res.isUpdateProfileSkipped)) {
              if (res.isUpdateProfileSkipped == false) {
                if (!isNullEmptyOrFalse(res.daysSinceLastUpdate)) {
                  if (res.daysSinceLastUpdate! > 14) {
                    profileCheck.value = true;
                  }
                }
              }
            }
          }

          if (!isNullEmptyOrFalse(res.name)) {
            box.write(ArgumentConstant.doctorName, res.name.toString());
            doctorName.value = res.name!;
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class EggRetreivalDataModel {
  String? id;
  String? userDbId;
  String? patientName;
  String? procedureName;
  DateTime? dateTime;
  EggRetreivalDataModel(
      {this.id,
      this.userDbId,
      this.dateTime,
      this.procedureName,
      this.patientName});
}
