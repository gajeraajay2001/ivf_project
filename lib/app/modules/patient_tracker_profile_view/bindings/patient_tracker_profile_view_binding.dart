import 'package:get/get.dart';

import '../controllers/patient_tracker_profile_view_controller.dart';

class PatientTrackerProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerProfileViewController>(
      () => PatientTrackerProfileViewController(),
    );
  }
}
