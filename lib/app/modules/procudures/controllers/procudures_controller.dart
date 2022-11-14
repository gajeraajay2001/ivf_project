import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivf_project/app/models/procedure_listing_model.dart';
import 'package:ivf_project/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../../../data/NetworkClient.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/progress_dialog_utils.dart';

class ProcuduresController extends GetxController {
  ScrollController scrollController = ScrollController();
  GlobalKey customizeYourProcedureShowCaseKey = GlobalKey();
  Rx<GlobalKey> eggDonorShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> completeProcedureShowCaseKey = GlobalKey().obs;
  RxBool hasData = false.obs;
  RxList<Procedures> procedures = RxList<Procedures>([]);
  ItemScrollController itemScrollController = ItemScrollController();
  RxBool isProcedureViewed = false.obs;
  RxString isRecentlyAddedOrEditedProcedureDbId = "".obs;
  RxBool isTourStarted = false.obs;
  RxBool isDownDone = false.obs;
  RxBool tourViewed = false.obs;
  @override
  void onInit() {
    callProceduresListingApi(context: Get.context!);
    print("My Id: = ${isRecentlyAddedOrEditedProcedureDbId.value}:=");
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
    hasData.value = false;
    procedures.clear();
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
        hasData.refresh();
        if (response["status_code"] == 200 && response["response"] == true) {
          ProcedureListingModel res = ProcedureListingModel.fromJson(response);
          box.write(ArgumentConstant.procedureId, res.procedures![0].id!);
          if (!isNullEmptyOrFalse(res.procedureTypes)) {
            res.procedures!.forEach((element) {
              procedures.add(element);
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
        hasData.refresh();
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  deleteProcedureApi({required BuildContext context, required String id}) {
    Map<String, dynamic> dict = {};
    dict["procedure_db_id"] = id;
    app.resolve<CustomDialogs>().showCircularDialog(context);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.deleteProcedureApi,
      MethodType.Delete,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        hasData.refresh();
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          callProceduresListingApi(context: context);
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

  updateTourStepApi({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["step"] = 1;
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
          box.write(ArgumentConstant.tourStep1Completed, false);
          box.write(ArgumentConstant.tourStep1Started, false);
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
