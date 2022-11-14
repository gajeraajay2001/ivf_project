import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/models/patient_tracker_procedure_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../data/NetworkClient.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/progress_dialog_utils.dart';
import '../../patients/controllers/patients_controller.dart';

class PatientTrackerScreenController extends GetxController {
  Rx<GlobalKey> reportShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> moreActionsShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> finalShowCaseKey = GlobalKey().obs;
  PageController pageController = PageController();
  PatientsController patientController = PatientsController();
  RxInt selectedPageIndex = 1.obs;
  RxList<PatientTrackerMenuModel> patientTrackerMenuModel = [
    PatientTrackerMenuModel(isActive: false.obs, title: "Profile"),
    PatientTrackerMenuModel(isActive: true.obs, title: "Schedule"),
    PatientTrackerMenuModel(isActive: false.obs, title: "Reports"),
    PatientTrackerMenuModel(isActive: false.obs, title: "Contacts"),
  ].obs;
  RxBool hasData = false.obs;
  RxList<Detail> procedureDetailsList = RxList<Detail>([]);
  String patientProcedureDbId = "";
  String patientName = "";
  String patientAge = "0";
  String patientMobileNumber = "";
  String patientProcedureName = "";
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  RxBool isTodayViewed = false.obs;
  RxString msCycleStart = "".obs;
  RxBool tourViewed = false.obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 1);
    Get.lazyPut<PatientsController>(() => PatientsController());
    patientController = Get.find<PatientsController>();
    if (!isNullEmptyOrFalse(Get.arguments)) {
      patientProcedureDbId =
          Get.arguments[ArgumentConstant.patientProcedureDbId];
      if (!isNullEmptyOrFalse(
          Get.arguments[ArgumentConstant.msCycleStartDate])) {
        msCycleStart.value = Get.arguments[ArgumentConstant.msCycleStartDate];
      }
      getProcedureDetails(context: Get.context!);
    }

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
      ApiConstant.patientProcedureApi +
          "?patient_procedure_db_id=$patientProcedureDbId",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        procedureDetailsList.clear();
        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          PatientTrackerProcedureModel res =
              PatientTrackerProcedureModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patientProcedure)) {
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((element) {
                procedureDetailsList.add(element);
              });
            }
            if (!isNullEmptyOrFalse(res.patientProcedure!.patientName)) {
              patientName = res.patientProcedure!.patientName!;
            }
            if (!isNullEmptyOrFalse(res.patientProcedure!.age)) {
              patientAge = res.patientProcedure!.age!;
            }

            if (!isNullEmptyOrFalse(res.patientProcedure!.procedure)) {
              if (!isNullEmptyOrFalse(res.patientProcedure!.procedure!.name)) {
                patientProcedureName = res.patientProcedure!.procedure!.name!;
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

  callAssignProcedureApi({required BuildContext context}) {
    Map<String, dynamic> dict = {};
    dict["name"] = patientName;
    dict["mobile_number"] = patientMobileNumber;
    dict["country_code"] = "+91";
    dict["procedure_db_id"] = patientProcedureDbId;
    app.resolve<CustomDialogs>().showCircularDialog(context);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.addPatientApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          print(response);
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
                      "Patient Invited\nSuccessfully",
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
            () => Get.offAndToNamed(Routes.ASSIGN_PROCEDURE_SCREEN, arguments: {
              ArgumentConstant.addedPatientName: patientName,
              ArgumentConstant.addedPatientProcedureName: patientProcedureName,
              ArgumentConstant.addedPatientDbId: response["user_detail"]["id"],
              ArgumentConstant.addedPatientProcedureDbId:
                  response["patient_procedure"]["id"]
            }),
          );
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

  deletePatient({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["user_db_id"] = box.read(ArgumentConstant.getUserDbId);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.deletePatientApi,
      MethodType.Delete,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        hasData.value = true;
        if (response["status_code"] == 200 && response["response"] == true) {
          patientController.callProceduresListingApi(context: context);
          Get.back();
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

  updateTourStepApi({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["step"] = 3;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateTourStepApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;
        hasData.refresh();
        if (response["status_code"] == 200 && response["response"] == true) {
          box.write(ArgumentConstant.tourStep3Started, false);
          box.write(ArgumentConstant.tourStep3Completed, true);
          box.write(ArgumentConstant.allTourStepsJustCompleted, true);
          Get.offAllNamed(Routes.HOME_SCREEN);
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        hasData.value = true;
        hasData.refresh();
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }
}

class PatientTrackerMenuModel {
  String? title;
  RxBool? isActive;
  PatientTrackerMenuModel({this.title, this.isActive});
}
