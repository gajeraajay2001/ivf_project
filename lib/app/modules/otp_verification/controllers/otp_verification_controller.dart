import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/otp_response_model.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';

class OtpVerificationController extends GetxController {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  GetStorage box = GetStorage();
  String mobileNumber = "";
  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void onInit() {
    if (Get.arguments["mobileNumber"] != null) {
      mobileNumber = Get.arguments["mobileNumber"];
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callOtpVerificationApi({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["mobile_number"] = mobileNumber;
    dict["otp"] = pinPutController.text.toString();
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.loginApi,
      MethodType.Put,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200) {
          box.write(ArgumentConstant.mobileNumber, mobileNumber);
          if (response["is_account_created"] == true) {
            box.write(ArgumentConstant.isAccountCreated, true);
            OtpResponseModel res = OtpResponseModel.fromJson(response);
            box.write(ArgumentConstant.token, res.token);
            if (!isNullEmptyOrFalse(res.userDetail)) {
              box.write(ArgumentConstant.userId, res.userDetail!.userId);
              if (res.userDetail!.isDoctor!) {
                Get.offAllNamed(Routes.HOME_SCREEN);
                box.write(ArgumentConstant.userRole, Role.doctor);
              } else {
                Get.offAllNamed(Routes.PATIENT_HOME_SCREEN);
                box.write(ArgumentConstant.userRole, Role.patient);
              }
            }
          } else {
            box.write(ArgumentConstant.isAccountCreated, false);
            box.write(ArgumentConstant.mobileNumber, mobileNumber);
            Get.toNamed(Routes.CREATE_ACCOUNT);
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }
}
