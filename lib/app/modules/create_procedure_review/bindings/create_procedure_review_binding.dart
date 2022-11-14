import 'package:get/get.dart';

import '../controllers/create_procedure_review_controller.dart';

class CreateProcedureReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProcedureReviewController>(
      () => CreateProcedureReviewController(),
    );
  }
}
