import 'package:get/get.dart';

import '../controllers/create_account_patient_controller.dart';

class CreateAccountPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountPatientController>(
      () => CreateAccountPatientController(),
    );
  }
}
