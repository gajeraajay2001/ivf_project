import 'package:get/get.dart';

import '../controllers/add_new_patient_screen_controller.dart';

class AddNewPatientScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewPatientScreenController>(
      () => AddNewPatientScreenController(),
    );
  }
}
