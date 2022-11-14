import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';

import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../data/NetworkClient.dart';
import '../../../routes/app_pages.dart';

class PatientTrackerTerminateController extends GetxController {
  Rx<TextEditingController> selectedDate = TextEditingController().obs;
  TextEditingController noteController = TextEditingController();
  RxBool reason1 = false.obs;
  RxBool reason2 = false.obs;
  RxBool reason3 = false.obs;
  @override
  void onInit() {
    selectedDate.value.text = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    super.onInit();
  }

  terminateProcedure({required BuildContext context, required String userId}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["user_db_id"] = userId;

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.terminateProcedure,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          Get.offAllNamed(Routes.HOME_SCREEN);
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
