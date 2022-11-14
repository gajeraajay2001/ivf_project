import 'package:get/get.dart';

import '../controllers/terms_usages_controller.dart';

class TermsUsagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsUsagesController>(
      () => TermsUsagesController(),
    );
  }
}
