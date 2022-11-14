import 'package:get/get.dart';

import '../controllers/doctor_my_profile_controller.dart';

class DoctorMyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorMyProfileController>(
      () => DoctorMyProfileController(),
    );
  }
}
