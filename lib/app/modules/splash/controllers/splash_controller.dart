import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';

import '../../../services/notification_handler.dart';

class SplashController extends GetxController {
  GetStorage box = GetStorage();
  String token = "";
  @override
  void onInit() {
    box.write(ArgumentConstant.tourStep1Started, false);
    box.write(ArgumentConstant.tourStep1Completed, false);
    box.write(ArgumentConstant.tourStep2Started, false);
    box.write(ArgumentConstant.tourStep2Completed, false);
    box.write(ArgumentConstant.tourStep3Started, false);
    box.write(ArgumentConstant.tourStep3Completed, false);
    box.write(ArgumentConstant.allTourStepsJustCompleted, false);
    if (box.read(ArgumentConstant.token) != null) {
      // box.write(ArgumentConstant.token, "");
      token = box.read(ArgumentConstant.token);
    }
    Timer(
      Duration(seconds: 3),
      () => (isNullEmptyOrFalse(token))
          ? Get.offAllNamed(Routes.SIGN_IN)
          : (box.read(ArgumentConstant.userRole) == Role.patient)
              ? Get.offAllNamed(Routes.PATIENT_HOME_SCREEN)
              : Get.offAllNamed(Routes.HOME_SCREEN),
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
