import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ivf_project/app/constants/app_module.dart';
import 'package:kiwi/kiwi.dart';
import 'app/routes/app_pages.dart';

late KiwiContainer app;
GetStorage box = GetStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
