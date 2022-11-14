import 'package:get/get.dart';

import '../controllers/patient_tracker_reports_view_controller.dart';

class PatientTrackerReportsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerReportsViewController>(
      () => PatientTrackerReportsViewController(),
    );
  }
}
