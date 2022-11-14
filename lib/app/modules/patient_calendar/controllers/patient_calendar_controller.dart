import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/modules/assign_procedure_screen/controllers/assign_procedure_screen_controller.dart';
import 'package:ivf_project/app/modules/edit_event/controllers/edit_event_controller.dart';
import 'package:ivf_project/app/modules/patient_tracker_screen/controllers/patient_tracker_screen_controller.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import '../../../../main.dart';

class PatientCalendarController extends GetxController {
  AssignProcedureScreenController? assignProcedureScreenController;
  EditEventController? editEventController;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  bool asDoctor = false;
  bool asPatient = false;
  bool isForEditEventFromPatientTracker = false;
  bool isFormsCycleStartDateUpdate = false;
  Rx<DateTime> msCycleStart = DateTime.now().obs;
  PatientTrackerScreenController patientTrackerScreenController =
      PatientTrackerScreenController();
  @override
  void onInit() {
    if (!isNullEmptyOrFalse(Get.arguments)) {
      if (Get.arguments[ArgumentConstant.asPatient] != null) {
        asPatient = Get.arguments[ArgumentConstant.asPatient];
        if (!isNullEmptyOrFalse(Get.arguments[ArgumentConstant.selectedDate])) {
          selectedDay.value = Get.arguments[ArgumentConstant.selectedDate];
          focusedDay.value = Get.arguments[ArgumentConstant.selectedDate];
        }
      } else {
        if (Get.arguments[ArgumentConstant.isFormsCycleStartDateUpdate] !=
            null) {
          isFormsCycleStartDateUpdate =
              Get.arguments[ArgumentConstant.isFormsCycleStartDateUpdate];
          if (Get.arguments[ArgumentConstant.msCycleStartDate] != null) {
            msCycleStart.value = DateFormat("dd MMMM yyyy")
                .parse(Get.arguments[ArgumentConstant.msCycleStartDate]);
            asDoctor = Get.arguments[ArgumentConstant.asDoctor];
            selectedDay.value = msCycleStart.value;
            focusedDay.value = msCycleStart.value;
            Get.lazyPut(() => PatientTrackerScreenController());
            patientTrackerScreenController =
                Get.find<PatientTrackerScreenController>();
          }
        } else {
          if (Get.arguments[
                  ArgumentConstant.isForEditEventFromPatientTracker] !=
              null) {
            isForEditEventFromPatientTracker = Get
                .arguments[ArgumentConstant.isForEditEventFromPatientTracker];
            Get.lazyPut<EditEventController>(() => EditEventController());
            editEventController = Get.find<EditEventController>();
          } else {
            Get.lazyPut<AssignProcedureScreenController>(
                () => AssignProcedureScreenController());
            assignProcedureScreenController =
                Get.find<AssignProcedureScreenController>();
          }
          asDoctor = Get.arguments[ArgumentConstant.asDoctor];
          if (!isNullEmptyOrFalse(
              Get.arguments[ArgumentConstant.selectedDate])) {
            selectedDay.value = Get.arguments[ArgumentConstant.selectedDate];
            focusedDay.value = Get.arguments[ArgumentConstant.selectedDate];
          }
        }
      }
    }
    super.onInit();
  }

  updateMsCycleDate({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["ms_cycle_start"] =
        DateFormat("dd MMMM yyyy").format(selectedDay.value);
    if (!asPatient) {
      dict["user_db_id"] =
          (!isNullEmptyOrFalse(box.read(ArgumentConstant.getUserDbId)))
              ? box.read(ArgumentConstant.getUserDbId)
              : "";
    }
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateMsCycleDate,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        if (response["status_code"] == 200 && response["response"] == true) {
          patientTrackerScreenController.msCycleStart.value =
              DateFormat("dd MMMM yyyy").format(selectedDay.value);
          Get.back();
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
