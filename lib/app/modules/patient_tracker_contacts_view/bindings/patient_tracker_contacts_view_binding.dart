import 'package:get/get.dart';

import '../controllers/patient_tracker_contacts_view_controller.dart';

class PatientTrackerContactsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientTrackerContactsViewController>(
      () => PatientTrackerContactsViewController(),
    );
  }
}
