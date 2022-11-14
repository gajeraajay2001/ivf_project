import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorMyProfileController extends GetxController {
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController licenceIdController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController localityController = TextEditingController();
  Rx<TextEditingController> cityController = TextEditingController().obs;
  TextEditingController zipCodeController = TextEditingController();
  Rx<TextEditingController> qualificationController =
      TextEditingController().obs;
  RxList qualificationList = ["MBBS", "QA", "BA"].obs;
  RxList cityList = ["Mumbai", "Pune", "Test"].obs;
  @override
  void onInit() {
    qualificationController.value.text = "MBBS";
    cityController.value.text = "Select One";

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
