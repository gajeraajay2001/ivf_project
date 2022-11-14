import 'package:get/get.dart';

import '../controllers/create_procedure_customise_controller.dart';

class CreateProcedureCustomiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProcedureCustomiseController>(
      () => CreateProcedureCustomiseController(),
    );
  }
}
