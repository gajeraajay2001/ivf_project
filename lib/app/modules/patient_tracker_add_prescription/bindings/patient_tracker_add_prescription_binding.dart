import 'package:get/get.dart';

import '../controllers/patient_tracker_add_prescription_controller.dart';

class PatientTrackerAddPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerAddPrescriptionController>(
      () => PatientTrackerAddPrescriptionController(),
    );
  }
}
