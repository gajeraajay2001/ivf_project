import 'package:get/get.dart';

import '../controllers/patient_home_screen_controller.dart';

class PatientHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientHomeScreenController>(
      () => PatientHomeScreenController(),
    );
  }
}
