import 'package:get/get.dart';

import '../controllers/patient_my_reports_controller.dart';

class PatientMyReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientMyReportsController>(
      () => PatientMyReportsController(),
    );
  }
}
