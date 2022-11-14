import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../main.dart';
import '../../../data/NetworkClient.dart';
import '../../../utilities/progress_dialog_utils.dart';

class AssignProcedureScreenController extends GetxController {
  Rx<GlobalKey> mcSymbolShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> nextMcDateShowCaseKey = GlobalKey().obs;
  String procedureDbId = "";
  RxString assignedProcedureName = "".obs;
  RxString addedPatientName = "".obs;
  RxString addedPatientProcedureDbId = "".obs;
  RxString addedPatientDbId = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedDateString = DateFormat("dd-MMMM-yyy")
      .format(DateTime.now().subtract(Duration(days: 0)))
      .obs;
  RxBool isMcDateSelected = false.obs;
  RxBool isShowCaseShowed = false.obs;
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      addedPatientName.value = Get.arguments[ArgumentConstant.addedPatientName];
      assignedProcedureName.value =
          Get.arguments[ArgumentConstant.addedPatientProcedureName];
      addedPatientDbId.value = Get.arguments[ArgumentConstant.addedPatientDbId];
      addedPatientProcedureDbId.value =
          Get.arguments[ArgumentConstant.addedPatientProcedureDbId];
      procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
    }

    super.onInit();
  }

  callPatientProcedureAssignment({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["ms_cycle_start"] = DateFormat("dd MMMM yyy")
        .format(selectedDate.value.add(Duration(days: 0)));
    dict["user_db_id"] = addedPatientDbId.value;
    dict["patient_procedure_db_id"] = addedPatientProcedureDbId.value;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientProcedureAssignmentApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        if (response["status_code"] == 200 && response["response"] == true) {
          Get.offAllNamed(Routes.HOME_SCREEN, arguments: {
            ArgumentConstant.isForAddedPatient: false,
          });
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
