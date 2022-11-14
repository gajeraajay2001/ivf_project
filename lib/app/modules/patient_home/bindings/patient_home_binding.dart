import 'package:get/get.dart';

import '../controllers/patient_home_controller.dart';

class PatientHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientHomeController>(
      () => PatientHomeController(),
    );
  }
}
