import 'package:get/get.dart';

import '../controllers/patient_tracker_terminate_controller.dart';

class PatientTrackerTerminateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerTerminateController>(
      () => PatientTrackerTerminateController(),
    );
  }
}
