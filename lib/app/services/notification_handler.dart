import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

import '../routes/app_pages.dart';

class AwesomeNotificationHandler {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
  }
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
  }
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if(!isNullEmptyOrFalse(receivedAction.payload)) {
      if (!isNullEmptyOrFalse(receivedAction.payload!["id"])) {
        Get.offAllNamed(
            Routes.SPLASH, arguments: {"id": receivedAction.payload!["id"],"data":receivedAction.buttonKeyInput.toString(),});
      }
    }
  }
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
   if(!isNullEmptyOrFalse(receivedAction.payload)){
     if(!isNullEmptyOrFalse(receivedAction.payload!["id"])){
       Get.offAllNamed(Routes.SPLASH,arguments: {"id" : receivedAction.payload!["id"]});
     }
   }


  }

  static Future<void> init() async {
    messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
