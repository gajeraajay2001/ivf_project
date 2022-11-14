import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/patients_list_model.dart';
import 'package:ivf_project/app/models/procedure_listing_model.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../routes/app_pages.dart';

class PatientsController extends GetxController {
  ItemScrollController itemScrollController = ItemScrollController();
  ItemScrollController itemScrollController2 = ItemScrollController();
  ItemScrollController itemScrollController3 = ItemScrollController();
  Rx<GlobalKey> addPatientShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> newlyAddedPatientShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> newlyAddedPatientShowCaseKey2 = GlobalKey().obs;
  RxString addedPatientProcedureDbId = "".obs;
  RxString addedPatientDbId = "".obs;
  RxBool notAssigned = true.obs;
  RxBool hasData = false.obs;
  RxList<Procedures> procedureTypesList = RxList<Procedures>([]);
  RxList<Patients> patientsList = RxList<Patients>([]);
  RxList<Patients> dummyPatientsList = RxList<Patients>([]);
  RxBool isShowCaseShowed = false.obs;
  RxBool isAddPatientShowed = false.obs;
  RxBool isProcedureViewed = false.obs;
  RxBool isPatientViewed = false.obs;
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  @override
  void onInit() {
    callProceduresListingApi(context: Get.context!);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callProceduresListingApi({required BuildContext context}) {
    hasData.value = false;
    procedureTypesList.clear();
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.procedureListingApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          procedureTypesList.clear();
          ProcedureListingModel res = ProcedureListingModel.fromJson(response);

          if (!isNullEmptyOrFalse(res.procedures)) {
            res.procedures!.forEach((element) {
              procedureTypesList.add(element);
            });
            if (!isNullEmptyOrFalse(procedureTypesList)) {
              procedureTypesList[0].isActive!.value = true;
              procedureTypesList[0].isSelected!.value = true;
            }
            if (!isNullEmptyOrFalse(addedPatientDbId.value) &&
                !isNullEmptyOrFalse(addedPatientProcedureDbId.value)) {
              procedureTypesList.forEach((element) {
                if (element.id == addedPatientProcedureDbId.value) {
                  procedureTypesList[0].isActive!.value = false;
                  procedureTypesList[0].isSelected!.value = false;
                  element.isSelected!.value = true;
                  element.isActive!.value = true;
                }
              });
            }
          }
          if (!isNullEmptyOrFalse(procedureTypesList)) {
            procedureTypesList.forEach((element) {
              if (element.isSelected!.isTrue) {
                callPatientsListAPi(
                    context: context, selectedProcedureName: element.name!);
              }
            });
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

  callPatientsListAPi(
      {required BuildContext context, required String selectedProcedureName}) {
    dummyPatientsList.clear();
    patientsList.clear();
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
        dummyPatientsList.clear();
        patientsList.clear();
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          isPatientViewed.value = false;
          PatientsListModel res = PatientsListModel.fromJson(response);

          if (!isNullEmptyOrFalse(res.patients)) {
            res.patients!.forEach((element) {
              dummyPatientsList.add(element);

              if (!isNullEmptyOrFalse(procedureTypesList)) {
                getPatientsByProcedureName(
                    procedureName: selectedProcedureName);
              }

              // patientsList.add(element);
            });
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

  getPatientsByProcedureName({required String procedureName}) {
    patientsList.clear();
    if (procedureName != "Not Assigned") {
      patientsList.addAll(dummyPatientsList);
      if (procedureName != "Not Assigned") {
        patientsList.removeWhere(
            (element) => (element.patient!.procedure!.name! != procedureName));
      }
    }
  }

  updateTourStepApi({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["step"] = 2;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateTourStepApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;
        hasData.refresh();
        if (response["status_code"] == 200 && response["response"] == true) {
          box.write(ArgumentConstant.tourStep2Completed, false);
          box.write(ArgumentConstant.tourStep2Started, false);
          box.write(ArgumentConstant.tourStep3Started, true);
          box.write(ArgumentConstant.tourStep3Completed, false);

          ShowCaseWidget.of(context)
              .startShowCase([newlyAddedPatientShowCaseKey2.value]);
          // Get.offAllNamed(Routes.HOME_SCREEN);
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;
        hasData.refresh();
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }
}
