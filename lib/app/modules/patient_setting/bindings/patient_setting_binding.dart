import 'package:get/get.dart';

import '../controllers/patient_setting_controller.dart';

class PatientSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientSettingController>(
      () => PatientSettingController(),
    );
  }
}
