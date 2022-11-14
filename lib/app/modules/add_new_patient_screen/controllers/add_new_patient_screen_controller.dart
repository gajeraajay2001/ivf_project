import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/models/procedure_listing_model.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../data/NetworkClient.dart';
import '../../../utilities/progress_dialog_utils.dart';
import '../../patients/controllers/patients_controller.dart';

class AddNewPatientScreenController extends GetxController {
  PatientsController? patientsController;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  RxList<Procedures> procedureTypesList = RxList<Procedures>([]);
  RxBool hasData = false.obs;
  RxBool isProcedureSelected = false.obs;

  @override
  void onInit() {
    Get.lazyPut<PatientsController>(
      () => PatientsController(),
    );

    patientsController = Get.find<PatientsController>();
    if (Get.arguments != null) {
      fullNameController.text =
          Get.arguments[ArgumentConstant.addedPatientName];
      mobileNumberController.text = Get
          .arguments[ArgumentConstant.addedPatientNumber]
          .toString()
          .trim()
          .replaceAll(" ", "");
    }
    callProceduresListingApi(context: Get.context!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callProceduresListingApi({required BuildContext context}) {
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.procedureListingApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          ProcedureListingModel res = ProcedureListingModel.fromJson(response);

          if (!isNullEmptyOrFalse(res.procedures)) {
            res.procedures!.forEach((element) {
              procedureTypesList.add(element);
            });
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

  callAddPatientsApi({required BuildContext context}) {
    String selectedId = "";
    String assignedProcedureName = "";
    List<String> mobileNumber = [];
    String number =
        mobileNumberController.text.toString().trim().replaceAll(" ", "");
    if (mobileNumberController.text.contains("+91")) {
      mobileNumber = mobileNumberController.text.split("+91");
      if (mobileNumber.length > 1) {
        number = mobileNumber[1];
      }
    }
    procedureTypesList.forEach((element) {
      if (element.isActive!.isTrue) {
        selectedId = element.id!;
        assignedProcedureName = element.name!;
      }
    });
    Map<String, dynamic> dict = {};
    dict["name"] = fullNameController.text.trim();
    dict["mobile_number"] = number;
    dict["country_code"] = "+91";
    dict["procedure_db_id"] = selectedId;
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

          patientsController!.callProceduresListingApi(context: context);
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
            Duration(milliseconds: 700),
            () => Get.offAndToNamed(Routes.ASSIGN_PROCEDURE_SCREEN, arguments: {
              ArgumentConstant.addedPatientName: fullNameController.text.trim(),
              ArgumentConstant.addedPatientProcedureName: assignedProcedureName,
              ArgumentConstant.addedPatientDbId: response["user_detail"]["id"],
              ArgumentConstant.addedPatientProcedureDbId:
                  response["patient_procedure"]["id"],
              ArgumentConstant.procedureDbId: selectedId,
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
}
