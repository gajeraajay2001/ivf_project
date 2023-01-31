import 'package:get/get.dart';

import '../controllers/notification_redirection_screen_controller.dart';

class NotificationRedirectionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRedirectionScreenController>(
      () => NotificationRedirectionScreenController(),
    );
  }
}
