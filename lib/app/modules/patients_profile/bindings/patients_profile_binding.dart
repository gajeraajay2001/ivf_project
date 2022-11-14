import 'package:get/get.dart';

import '../controllers/patients_profile_controller.dart';

class PatientsProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientsProfileController>(
      () => PatientsProfileController(),
    );
  }
}
