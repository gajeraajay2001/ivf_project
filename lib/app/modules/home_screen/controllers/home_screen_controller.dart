import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/modules/home_screen/views/home_screen_view.dart';

import '../../../utilities/image_constant.dart';
import '../../patients/controllers/patients_controller.dart';
import '../../procudures/controllers/procudures_controller.dart';

class HomeScreenController extends GetxController {
  PatientsController patientsController = PatientsController();
  ProcuduresController procuduresController = ProcuduresController();
  RxInt selectIndex = 0.obs;
  PageController? pageController;
  bool isForPatients = false;
  bool isNavigateToPatientsScreen = false;
  bool isNavigateToProcedureScreen = false;
  List<BottomMenuModel> bottomMenu = [
    BottomMenuModel(
        image: ImageConstant.imgCalendarcale7,
        label: "Home",
        isActive: true.obs,
        index: 0),
    BottomMenuModel(
        image: ImageConstant.imgIconlybulk3u8,
        label: "Patients",
        isActive: false.obs,
        index: 1),
    BottomMenuModel(
        image: ImageConstant.imgIconlybulkfol6,
        label: "Procedures",
        isActive: false.obs,
        index: 2),
    BottomMenuModel(
        image: ImageConstant.imgBasicsetting4,
        label: "Settings",
        isActive: false.obs,
        index: 3),
  ];

  @override
  void onInit() {
    Get.lazyPut(() => PatientsController());
    patientsController = Get.find<PatientsController>();
    if (!isNullEmptyOrFalse(Get.arguments)) {
      if (!isNullEmptyOrFalse(
          Get.arguments[ArgumentConstant.isForAddedPatient])) {
        isForPatients = Get.arguments[ArgumentConstant.isForAddedPatient];
      }
      if (!isNullEmptyOrFalse(
          Get.arguments[ArgumentConstant.isNavigateToPatientsScreen])) {
        isNavigateToPatientsScreen =
            Get.arguments[ArgumentConstant.isNavigateToPatientsScreen];
      }
      if (!isNullEmptyOrFalse(
          Get.arguments[ArgumentConstant.isNavigateToProcedureScreen])) {
        isNavigateToProcedureScreen =
            Get.arguments[ArgumentConstant.isNavigateToProcedureScreen];
      }
    }
    if (isForPatients) {
      selectIndex.value = 1;
      bottomMenu.forEach((element) {
        element.isActive!.value = false;
      });
      bottomMenu[1].isActive!.value = true;
      pageController = PageController(initialPage: 1);
      isForPatients = false;
    } else if (isNavigateToProcedureScreen) {
      Get.lazyPut(() => ProcuduresController());
      procuduresController = Get.find<ProcuduresController>();
      procuduresController.isRecentlyAddedOrEditedProcedureDbId.value =
          Get.arguments[ArgumentConstant.procedureDbId];
      selectIndex.value = 2;
      bottomMenu.forEach((element) {
        element.isActive!.value = false;
      });
      bottomMenu[2].isActive!.value = true;
      pageController = PageController(initialPage: 2);
    } else {
      pageController = PageController(initialPage: 0);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isNavigateToPatientsScreen) {
        if (!isNullEmptyOrFalse(
                Get.arguments[ArgumentConstant.addedPatientDbId]) &&
            !isNullEmptyOrFalse(
                Get.arguments[ArgumentConstant.addedPatientProcedureDbId])) {
          patientsController.addedPatientProcedureDbId.value =
              Get.arguments[ArgumentConstant.procedureDbId];
          patientsController.addedPatientDbId.value =
              Get.arguments[ArgumentConstant.addedPatientDbId];
        }
        patientsController.callProceduresListingApi(context: Get.context!);
        patientsController.isShowCaseShowed.value = false;
        pageController!.jumpToPage(1);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
