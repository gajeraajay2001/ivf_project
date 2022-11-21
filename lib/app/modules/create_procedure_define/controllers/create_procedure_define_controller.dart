import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/modules/create_procedure_define/views/create_procedure_define_view.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';

import '../../../constants/api_constant.dart';
import '../../../models/procedure_listing_model.dart';

class CreateProcedureDefineController extends GetxController {
  TextEditingController procedureNameController = TextEditingController();
  Rx<GlobalKey> procedureNameShowCaseKey = GlobalKey().obs;
  RxString selectedProcedureName = "Egg Donor".obs;
  RxBool isButtonEnable = false.obs;
  RxBool hasData = false.obs;
  RxString errorText = "".obs;
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  RxList<ProcedureTypeModel> procedureTypeList = RxList<ProcedureTypeModel>([]);
  FocusNode textFieldFocusNode = FocusNode();
  @override
  void onInit() {
    callProceduresListingApi(context: Get.context!);
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
          box.write(ArgumentConstant.procedureId, res.procedures![0].id!);
          if (!isNullEmptyOrFalse(res.procedureTypes)) {
            res.procedureTypes!.forEach((element) {
              procedureTypeList.add(ProcedureTypeModel(
                  isActive: false.obs,
                  id: element.id,
                  title: element.title,
                  subTitle: element.description));
            });
          }
          if (!isNullEmptyOrFalse(procedureTypeList)) {
            procedureTypeList[0].isActive!.value = true;
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

  createNewProcedureApi(
      {required BuildContext context,
      required ProcedureTypeModel procedureTypeModel}) {
    Map<String, dynamic> dict = {};
    dict["name"] = procedureNameController.text.trim();
    dict["procedure_type_db_id"] = procedureTypeModel.id;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.createNewProcedureApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          if (!isNullEmptyOrFalse(response["procedure"]["id"])) {
            box.write(
                ArgumentConstant.procedureDbId, response["procedure"]["id"]);
          }
          Get.toNamed(Routes.CREATE_PROCEDURE_CUSTOMISE, arguments: {
            ArgumentConstant.selectedProcedureModel: procedureTypeModel
          });
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
}
