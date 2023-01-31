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
  String id = "";
  String message = "";

  @override
  void onInit() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: AwesomeNotificationHandler.onActionReceivedMethod,
      onNotificationCreatedMethod:
          AwesomeNotificationHandler.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          AwesomeNotificationHandler.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          AwesomeNotificationHandler.onDismissActionReceivedMethod,
    );
    box.write(ArgumentConstant.tourStep1Started, false);
    box.write(ArgumentConstant.tourStep1Completed, false);
    box.write(ArgumentConstant.tourStep2Started, false);
    box.write(ArgumentConstant.tourStep2Completed, false);
    box.write(ArgumentConstant.tourStep3Started, false);
    box.write(ArgumentConstant.tourStep3Completed, false);
    box.write(ArgumentConstant.allTourStepsJustCompleted, false);

    if (!isNullEmptyOrFalse(Get.arguments)) {
      id = Get.arguments["id"];
      if(!isNullEmptyOrFalse(Get.arguments["data"])){
        message = Get.arguments["data"];
      }
    }

    if (box.read(ArgumentConstant.token) != null) {
      // box.write(ArgumentConstant.token, "");
      token = box.read(ArgumentConstant.token);
    }
    Timer(
      Duration(seconds: 3),
      () => (!isNullEmptyOrFalse(id))
          ? Get.offAllNamed(Routes.NOTIFICATION_REDIRECTION_SCREEN,
              arguments: {"id": id,"data":message})
          : (isNullEmptyOrFalse(token))
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
