import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

class AssignedProcedurePage2Controller extends GetxController {
  RxString teamContactController = "".obs;
  RxString agentContactController = "".obs;
  RxString embryologistContactController = "".obs;
  RxString coPatientContactController = "".obs;
  String patientName = "";
  String patientProcedureName = "";
  Rx<Contact>? teamContact;
  Rx<Contact>? agentContact;
  Rx<Contact>? embryologistContact;
  Rx<Contact>? coPatientContact;

  String addedPatientProcedureDbId = "";
  String procedureDbId = "";
  String addedPatientDbId = "";

  @override
  void onInit() {
    if (!isNullEmptyOrFalse(Get.arguments)) {
      patientName = Get.arguments[ArgumentConstant.addedPatientName];
      patientProcedureName =
          Get.arguments[ArgumentConstant.addedPatientProcedureName];
      if (!isNullEmptyOrFalse(Get.arguments[ArgumentConstant.procedureDbId])) {
        addedPatientProcedureDbId =
            Get.arguments[ArgumentConstant.addedPatientProcedureDbId];
        procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
        addedPatientDbId = Get.arguments[ArgumentConstant.addedPatientDbId];
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
