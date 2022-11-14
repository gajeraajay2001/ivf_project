import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';

import '../../../../main.dart';
import '../../../models/contact_list_model.dart';
import '../../../utilities/progress_dialog_utils.dart';

class PatientTrackerContactsViewController extends GetxController {
  RxBool hasData = false.obs;
  RxList<UsersContactData> userContactDataList = RxList<UsersContactData>([]);
  @override
  void onInit() {
    print("===>" + box.read(ArgumentConstant.getUserDbId));
    getAddedContacts(context: Get.context!);
    super.onInit();
  }

  getAddedContacts({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    hasData.value = false;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientContacts +
          "?user_db_id=${box.read(ArgumentConstant.getUserDbId)}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          ContactListModel res = ContactListModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.users)) {
            res.users!.forEach((element) {
              userContactDataList.add(element);
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
