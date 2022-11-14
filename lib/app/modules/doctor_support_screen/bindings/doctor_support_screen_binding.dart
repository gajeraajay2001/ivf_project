import 'package:get/get.dart';

import '../controllers/doctor_support_screen_controller.dart';

class DoctorSupportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorSupportScreenController>(
      () => DoctorSupportScreenController(),
    );
  }
}
