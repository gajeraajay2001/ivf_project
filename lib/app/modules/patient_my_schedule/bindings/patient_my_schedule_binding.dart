import 'package:get/get.dart';

import '../controllers/patient_my_schedule_controller.dart';

class PatientMyScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientMyScheduleController>(
      () => PatientMyScheduleController(),
    );
  }
}
