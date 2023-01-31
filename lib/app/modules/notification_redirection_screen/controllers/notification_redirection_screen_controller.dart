import 'package:get/get.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

class NotificationRedirectionScreenController extends GetxController {
  RxString id = "Nothing".obs;
  RxString message = "".obs;
  @override
  void onInit() {
    if(!isNullEmptyOrFalse(Get.arguments)){
      id.value = Get.arguments["id"];
      message.value = Get.arguments["data"];
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
