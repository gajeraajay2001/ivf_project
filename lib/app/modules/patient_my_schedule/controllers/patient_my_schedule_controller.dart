import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/patient_my_schedule_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../utilities/progress_dialog_utils.dart';

class PatientMyScheduleController extends GetxController {
  ItemScrollController itemScrollController = ItemScrollController();
  RxList<Detail> patientProcedureDetail = RxList<Detail>([]);
  RxBool isTodayViewed = false.obs;
  RxBool hasData = false.obs;

  @override
  void onInit() {
    getPatientMySchedule(context: Get.context!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((element) {
                patientProcedureDetail.add(element);
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
}
