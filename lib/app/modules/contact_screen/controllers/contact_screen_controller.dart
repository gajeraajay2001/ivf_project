import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/modules/assign_procedure_screen/controllers/assign_procedure_screen_controller.dart';

import '../../assigned_procedure_page_2/controllers/assigned_procedure_page_2_controller.dart';

class ContactScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  AssignedProcedurePage2Controller? assignProcedureScreenController;
  Rx<GlobalKey> patientContactShowCaseKey = GlobalKey().obs;
  RxBool hasData = false.obs;
  bool isPatient = false;
  bool isForAddTeam = false;
  bool isForAddAgent = false;
  bool isForAddEmbryologist = false;
  bool isForAddCoPatient = false;
  RxBool isSearchActive = false.obs;
  bool isForAssignedProcedure = false;
  RxList<Contact> contacts = RxList<Contact>([]);
  RxList<Contact> dummyContacts = RxList<Contact>([]);
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  @override
  void onInit() {
    getContact();
    super.onInit();
  }

  @override
  void onReady() {
    if (!isNullEmptyOrFalse(Get.arguments)) {
      isForAssignedProcedure =
          Get.arguments[ArgumentConstant.fromAssignedProcedure];
      isForAddTeam = Get.arguments[ArgumentConstant.isForAddTeam];
      isForAddAgent = Get.arguments[ArgumentConstant.isForAddAgent];
      isForAddEmbryologist =
          Get.arguments[ArgumentConstant.isForAddEmbryologist];
      isForAddCoPatient = Get.arguments[ArgumentConstant.isForAddCoPatient];
      if (isForAssignedProcedure) {
        Get.lazyPut<AssignedProcedurePage2Controller>(
            () => AssignedProcedurePage2Controller());
        assignProcedureScreenController =
            Get.find<AssignedProcedurePage2Controller>();
      }
    }
    super.onReady();
  }

  @override
  void onClose() {}

  void getContact() async {
    await ContactsService.getContacts(withThumbnails: false).then((value) {
      value.forEach((element) {
        contacts.add(element);
        dummyContacts.add(element);
      });
      hasData.value = true;
    });
  }

  filterData({required String text, bool isNumber = false}) {
    contacts.clear();
    contacts.addAll(dummyContacts);
    if (isNumber) {
      contacts.removeWhere((element) {
        if (!isNullEmptyOrFalse(element.phones)) {
          return (!element.phones![0].value.toString().trim().contains(text));
        } else {
          return true;
        }
      });
    } else {
      contacts.removeWhere((element) => (!element.displayName
          .toString()
          .trim()
          .toLowerCase()
          .contains(text)));
    }
  }

  Future<Uint8List?> getAvatar({required Contact contact}) async {
    return await ContactsService.getAvatar(contact);
  }
}
