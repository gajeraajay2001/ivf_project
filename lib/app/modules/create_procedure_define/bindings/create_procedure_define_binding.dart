import 'package:get/get.dart';

import '../controllers/create_procedure_define_controller.dart';

class CreateProcedureDefineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProcedureDefineController>(
      () => CreateProcedureDefineController(),
    );
  }
}
