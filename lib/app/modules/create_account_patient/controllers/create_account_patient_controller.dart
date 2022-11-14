import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountPatientController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isPatient = true.obs;
  RxBool isProfessional = false.obs;
  RxBool isAgent = false.obs;
  RxBool isEggDonor = true.obs;
  RxBool isSurrogate = false.obs;
  RxBool isEggSeeker = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
