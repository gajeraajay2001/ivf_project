import 'package:get/get.dart';

import '../controllers/doctor_setting_controller.dart';

class DoctorSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorSettingController>(
      () => DoctorSettingController(),
    );
  }
}
