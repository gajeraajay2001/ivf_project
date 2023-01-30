import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/app_module.dart';
import 'package:ivf_project/app/services/notification_service.dart';
import 'package:kiwi/kiwi.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AwesomeNotificationService.init();
  AwesomeNotificationService.showNotification(message: message);
}

late KiwiContainer app;
GetStorage box = GetStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await AwesomeNotificationService.init();
  await GetStorage.init();
  app = KiwiContainer();
  setup();
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: "kanu", canvasColor: Colors.white),
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

//Figma: https://www.figma.com/file/kLPNxNieGpTiW0r11pE3z6/FC-version_4?node-id=124%3A1161
