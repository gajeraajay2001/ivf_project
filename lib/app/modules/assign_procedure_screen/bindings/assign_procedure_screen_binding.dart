import 'package:get/get.dart';

import '../controllers/assign_procedure_screen_controller.dart';

class AssignProcedureScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignProcedureScreenController>(
      () => AssignProcedureScreenController(),
    );
  }
}
