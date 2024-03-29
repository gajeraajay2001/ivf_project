import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  RxString countryCode = "91".obs;
  TextEditingController mobileController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callLoginApi({required BuildContext context, required String phoneCode}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["mobile_number"] = "+$phoneCode${mobileController.text.trim()}";
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.loginApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200) {
          box.write(ArgumentConstant.phoneCode, "+$phoneCode");
          Get.toNamed(Routes.OTP_VERIFICATION, arguments: {
            "mobileNumber": "+$phoneCode${mobileController.text.trim()}"
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
            .getDialog(title: "Failed", desc: "Invalid Otp");
        print(" error");
      },
    );
  }
}
