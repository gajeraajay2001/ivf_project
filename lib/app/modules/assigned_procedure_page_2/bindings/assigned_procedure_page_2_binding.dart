import 'package:get/get.dart';

import '../controllers/assigned_procedure_page_2_controller.dart';

class AssignedProcedurePage2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignedProcedurePage2Controller>(
      () => AssignedProcedurePage2Controller(),
    );
  }
}
