import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/account_model.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';

class CreateAccountController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  GetStorage box = GetStorage();
  RxBool isPatient = false.obs;
  RxBool isDoctor = true.obs;
  RxBool isAgent = false.obs;
  String mobileNumber = "";
  @override
  void onInit() {
    if (box.read(ArgumentConstant.mobileNumber) != null) {
      mobileNumber = box.read(ArgumentConstant.mobileNumber);
      mobileController.text = mobileNumber;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callCreateAccountApi({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["mobile_number"] = mobileNumber;
    dict["name"] = fullNameController.text.trim();
    dict["email"] = emailController.text.trim();
    dict["role"] = (isPatient.isTrue)
        ? "patient"
        : (isDoctor.isTrue)
            ? "doctor"
            : "agent";

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.createAccountApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200) {
          AccountModel res = AccountModel.fromJson(response);
          if (!isNullEmptyOrFalse(res)) {
            if (!(box.read(ArgumentConstant.isAccountCreated))) {
              box.write(ArgumentConstant.token, res.token);
              if (isDoctor.isTrue) {
                box.write(ArgumentConstant.userRole, Role.doctor);
              } else if (isPatient.isTrue) {
                box.write(ArgumentConstant.userRole, Role.patient);
              }
            }
            if (!isNullEmptyOrFalse(res.userDetail)) {
              box.write(ArgumentConstant.userId, res.userDetail!.userId);
              if (isDoctor.isTrue) {
                box.write(ArgumentConstant.userRole, Role.doctor);
              } else if (isPatient.isTrue) {
                box.write(ArgumentConstant.userRole, Role.patient);
              }
            }
          }
          if (isDoctor.isTrue) {
            Get.toNamed(Routes.FTUE);
          } else if (isPatient.isTrue) {
            Get.toNamed(Routes.FTUE_PATIENT);
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
