import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/patient_procedure_model.dart';
import 'package:ivf_project/app/models/procedures_details_model.dart';
import 'package:ivf_project/app/modules/home_screen/controllers/home_screen_controller.dart';
import 'package:ivf_project/app/modules/home_screen/views/home_screen_view.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../procudures/controllers/procudures_controller.dart';

class CreateProcedureReviewController extends GetxController {
  ScrollController scrollController = ScrollController();
  Rx<GlobalKey> reviewShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> editShowCaseKey = GlobalKey().obs;
  RxBool hasData = false.obs;
  RxList<Detail> procedureDetailsList = RxList<Detail>([]);
  RxList<Details> addedPatientProcedureDetailsList = RxList<Details>([]);
  HomeScreenController? homeScreenController;
  ProcuduresController procuduresController = ProcuduresController();
  RxBool isAddedPatients = false.obs;
  RxString patientName = "".obs;
  RxString patientProcedureName = "".obs;
  RxString addedPatientProcedureDbId = "".obs;
  RxString addedPatientDbId = "".obs;
  String procedureDbId = "";
  bool isProcedureView = false;
  String msCycleStartDate = "";
  String procedureName = "";
  RxBool isWholeProcedureReview = false.obs;
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments[ArgumentConstant.isForAddedPatient] != null) {
      isAddedPatients.value = Get.arguments[ArgumentConstant.isForAddedPatient];
      addedPatientDbId.value = Get.arguments[ArgumentConstant.addedPatientDbId];
      addedPatientProcedureDbId.value =
          Get.arguments[ArgumentConstant.addedPatientProcedureDbId];
      msCycleStartDate = Get.arguments[ArgumentConstant.msCycleStartDate];
      procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
    }
    if (Get.arguments != null &&
        Get.arguments[ArgumentConstant.isProcedureView] != null) {
      isProcedureView = Get.arguments[ArgumentConstant.isProcedureView];
      procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
    }
    if (isAddedPatients.value) {
      getPatientProcedure(context: Get.context!);
    } else {
      getProcedureDetails(context: Get.context!);
    }
    if (isProcedureView) {
      Get.lazyPut<ProcuduresController>(
        () => ProcuduresController(),
      );

      procuduresController = Get.find<ProcuduresController>();
    } else {
      Get.lazyPut<HomeScreenController>(
        () => HomeScreenController(),
      );

      homeScreenController = Get.find<HomeScreenController>();
    }
    isTourStarted.value = box.read(ArgumentConstant.tourStep1Started);
    isTourStarted.refresh();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getProcedureDetails({required BuildContext context}) {
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.procedureDetailsApi +
          "?procedure_db_id=${(isProcedureView) ? procedureDbId : box.read(ArgumentConstant.procedureDbId)}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          ProcedureDetailModel res = ProcedureDetailModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.procedure)) {
            if (!isNullEmptyOrFalse(res.procedure!.detail)) {
              res.procedure!.detail!.forEach((element) {
                procedureDetailsList.add(element);
              });
              if (!isNullEmptyOrFalse(res.procedure!.name)) {
                procedureName = res.procedure!.name!;
              }
            }
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  getPatientProcedure({required BuildContext context}) {
    addedPatientProcedureDetailsList.clear();
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getPatientProcedureApi +
          "?patient_procedure_db_id=${addedPatientProcedureDbId.value}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          PatientProcedureModel res = PatientProcedureModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patientProcedure)) {
            patientName.value = res.patientProcedure!.patientName ?? "";
            patientProcedureName.value = res.patientProcedure!.procedure!.name!;
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((element) {
                addedPatientProcedureDetailsList.add(element);
              });
            }
          }
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  callUpdateProcedure({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    dict["procedure_db_id"] = box.read(ArgumentConstant.procedureDbId);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateProcedureApi,
      MethodType.Put,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        if (response["status_code"] == 200 && response["response"] == true) {
          Get.dialog(
            Scaffold(
              backgroundColor: Colors.white.withOpacity(0.8),
              body: Center(
                child: Column(
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      "assets/check_icon.svg",
                      height: MySize.getHeight(64),
                      width: MySize.getWidth(64),
                    ),
                    Space.width(MySize.getHeight(20)),
                    Text(
                      "New Procedure\nCreated",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MySize.getHeight(18),
                          fontWeight: FontWeight.bold,
                          color: appTheme.primaryTheme),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            barrierDismissible: false,
          );

          Timer(
            Duration(milliseconds: 400),
            () => Get.offAllNamed(Routes.HOME_SCREEN, arguments: {
              ArgumentConstant.isNavigateToProcedureScreen: true,
              ArgumentConstant.procedureDbId: response["procedure"]["id"],
            }),
          );
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  callPatientProcedureAssignment({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["ms_cycle_start"] = msCycleStartDate;
    dict["user_db_id"] = addedPatientDbId.value;
    dict["patient_procedure_db_id"] = addedPatientProcedureDbId.value;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patientProcedureAssignmentApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        if (response["status_code"] == 200 && response["response"] == true) {
          Get.offNamedUntil(
              Routes.ASSIGNED_PROCEDURE_PAGE_2, (route) => route.isFirst,
              arguments: {
                ArgumentConstant.addedPatientName: patientName.value,
                ArgumentConstant.addedPatientProcedureName:
                    patientProcedureName.value,
                ArgumentConstant.addedPatientProcedureDbId:
                    addedPatientProcedureDbId.value,
                ArgumentConstant.addedPatientDbId: addedPatientDbId.value,
                ArgumentConstant.procedureDbId: procedureDbId,
              });
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }
}
