import 'package:get/get.dart';

import '../controllers/procudures_controller.dart';

class ProcuduresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcuduresController>(
      () => ProcuduresController(),
    );
  }
}
