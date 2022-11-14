import 'package:get/get.dart';

import '../controllers/ftue_patient_controller.dart';

class FtuePatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FtuePatientController>(
      () => FtuePatientController(),
    );
  }
}
