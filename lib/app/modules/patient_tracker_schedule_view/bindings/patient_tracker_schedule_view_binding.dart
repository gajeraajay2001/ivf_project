import 'package:get/get.dart';

import '../controllers/patient_tracker_schedule_view_controller.dart';

class PatientTrackerScheduleViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerScheduleViewController>(
      () => PatientTrackerScheduleViewController(),
    );
  }
}
