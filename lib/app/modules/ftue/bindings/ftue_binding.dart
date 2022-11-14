import 'package:get/get.dart';

import '../controllers/ftue_controller.dart';

class FtueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FtueController>(
      () => FtueController(),
    );
  }
}
