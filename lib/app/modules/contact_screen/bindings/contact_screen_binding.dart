import 'package:get/get.dart';

import '../controllers/contact_screen_controller.dart';

class ContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactScreenController>(
      () => ContactScreenController(),
    );
  }
}
