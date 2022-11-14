import 'package:get/get.dart';

import '../controllers/patient_calendar_controller.dart';

class PatientCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientCalendarController>(
      () => PatientCalendarController(),
    );
  }
}
