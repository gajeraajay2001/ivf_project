import 'package:get/get.dart';

import '../controllers/patient_my_profile_controller.dart';

class PatientMyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientMyProfileController>(
      () => PatientMyProfileController(),
    );
  }
}
