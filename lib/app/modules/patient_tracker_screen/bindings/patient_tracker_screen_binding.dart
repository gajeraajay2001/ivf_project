import 'package:get/get.dart';

import '../controllers/patient_tracker_screen_controller.dart';

class PatientTrackerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerScreenController>(
      () => PatientTrackerScreenController(),
    );
  }
}
