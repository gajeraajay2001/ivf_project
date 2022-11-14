import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/patinets_procedure_details_model.dart';
import 'package:ivf_project/app/modules/create_procedure_customise/views/create_procedure_customise_view.dart';
import 'package:ivf_project/app/modules/create_procedure_define/views/create_procedure_define_view.dart';
import 'package:ivf_project/app/modules/create_procedure_review/controllers/create_procedure_review_controller.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:ivf_project/main.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../constants/sizeConstant.dart';
import '../../../models/event_listing_model.dart' hide Events;
import '../../../models/procedures_details_model.dart';

class CreateProcedureCustomiseController extends GetxController {
  ScrollController scrollController = ScrollController();
  Rx<GlobalKey> day00ShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> day01ShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> addDayShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> allEventsShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> deleteEventsShowCaseKey = GlobalKey().obs;
  Rx<GlobalKey> nextButtonShowCaseKey = GlobalKey().obs;
  RxBool isWholeProcedureReview = false.obs;
  CreateProcedureReviewController? createProcedureReviewController;
  RxBool isDragStarted = false.obs;
  RxBool isDeleteStarted = false.obs;
  RxInt deleteIndex = 0.obs;
  RxInt deleteImageIndex = 0.obs;
  ProcedureTypeModel? procedureTypeModel;
  RxBool hasData = false.obs;
  RxList<DragItem> dragItem = RxList<DragItem>([]);
  RxList<Detail> targetItem = RxList<Detail>([]);
  RxBool isAddedPatients = false.obs;
  RxString addedPatientProcedureDbId = "".obs;
  RxString addedPatientDbId = "".obs;
  String patientName = "";
  String patientProcedureName = "";
  RxBool isShrink = false.obs;
  bool isProcedureView = false;
  String procedureDbId = "";
  String msCycleStartDate = "";
  String procedureName = "";
  RxBool isTourStarted = false.obs;
  RxBool tourViewed = false.obs;
  RxBool isDragAddCompleted = false.obs;
  RxBool isDragDeleteCompleted = false.obs;
  RxInt eventAddedForTourIndex = 0.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[ArgumentConstant.isProcedureView] != null) {
        isProcedureView = Get.arguments[ArgumentConstant.isProcedureView];
        procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
      }
    }

    if (isAddedPatients.isTrue) {
      Get.lazyPut<CreateProcedureReviewController>(
        () => CreateProcedureReviewController(),
      );
      createProcedureReviewController =
          Get.find<CreateProcedureReviewController>();
    }

    if (Get.arguments[ArgumentConstant.addedPatientName] != null) {
      patientName = Get.arguments[ArgumentConstant.addedPatientName];
      if (Get.arguments[ArgumentConstant.addedPatientProcedureName] != null) {
        patientProcedureName =
            Get.arguments[ArgumentConstant.addedPatientProcedureName];
      }
    }

    if (Get.arguments[ArgumentConstant.isForAddedPatient] != null) {
      isAddedPatients.value = Get.arguments[ArgumentConstant.isForAddedPatient];
      msCycleStartDate = Get.arguments[ArgumentConstant.msCycleStartDate];
      if (isAddedPatients.isTrue) {
        addedPatientDbId.value =
            Get.arguments[ArgumentConstant.addedPatientDbId];
        addedPatientProcedureDbId.value =
            Get.arguments[ArgumentConstant.addedPatientProcedureDbId];
        procedureDbId = Get.arguments[ArgumentConstant.procedureDbId];
      }
    }

    if (Get.arguments != null) {
      procedureTypeModel =
          Get.arguments[ArgumentConstant.selectedProcedureModel];
    }
    getEventListing(context: Get.context!);
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

  getEventListing({required BuildContext context}) {
    dragItem.clear();
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.eventCallApi,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          EventListingModel res = EventListingModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.events)) {
            res.events!.forEach((element) {
              dragItem.add(
                DragItem(
                    id: element.id,
                    image: getImageById(id: element.id!),
                    isActive: false.obs,
                    name: element.title),
              );
            });
          }
          dragItem[0].isActive!.value = true;
          if (isAddedPatients.value) {
            callGetProcedureDetailsForPatients(context: context);
          } else {
            getProcedureDetails(context: context);
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

  getProcedureDetails({required BuildContext context}) {
    targetItem.clear();

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
                targetItem.add(element);
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

  callGetProcedureDetailsForPatients({required BuildContext context}) {
    targetItem.clear();
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getProcedureEventApi +
          "?patient_procedure_db_id=${addedPatientProcedureDbId.value}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        if (response["status_code"] == 200 && response["response"] == true) {
          PatientProcedureDetailModel res =
              PatientProcedureDetailModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.patientProcedure)) {
            if (!isNullEmptyOrFalse(res.patientProcedure!.detail)) {
              res.patientProcedure!.detail!.forEach((element) {
                targetItem.add(element);
              });
              if (!isNullEmptyOrFalse(res.patientProcedure!.procedure)) {
                if (!isNullEmptyOrFalse(
                    res.patientProcedure!.procedure!.name)) {
                  procedureName = res.patientProcedure!.procedure!.name!;
                }
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

  Future<void> callUpdateProcedureEvent({
    required BuildContext context,
    required int index,
    Detail? detail,
    DragItem? dragItem,
    bool isForAddDay = false,
    int day = 0,
  }) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["procedure_db_id"] = (isAddedPatients.isTrue)
        ? addedPatientProcedureDbId.value
        : (isProcedureView)
            ? procedureDbId
            : box.read(ArgumentConstant.procedureDbId);
    dict["day"] = (isForAddDay) ? day : detail!.day;
    dict["event_db_id"] =
        (isForAddDay) ? "624420e970c14f56956f3d18" : dragItem!.id;
    dict["event_name"] = (isForAddDay) ? "Meds" : dragItem!.name;
    dict["additional_instruction"] = "";
    dict["show_on_calendar"] = false;

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateProcedureEventApi,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          if (isForAddDay) {
            targetItem.add(Detail(date: "", day: day, isToday: false, events: [
              Events(
                eventName: "Meds",
                eventDbId: "624420e970c14f56956f3d18",
                additionalInstruction: "",
                uploads: [],
                isVisible: false,
                isActive: true.obs,
                image: getImageById(id: "624420e970c14f56956f3d18").obs,
              )
            ]));
          } else {
            bool isAvailable = false;
            targetItem[index].events!.forEach((element) {
              if (element.image == getImageById(id: dragItem!.id!).obs) {
                isAvailable = true;
              }
            });
            if (!isAvailable) {
              targetItem[index].events!.add(Events(
                  isActive: false.obs,
                  isVisible: true,
                  uploads: [],
                  additionalInstruction: "",
                  eventDbId: dragItem!.id,
                  eventName: dragItem.name,
                  image: getImageById(id: dragItem.id!).obs));
              if (isTourStarted.isTrue && tourViewed.isFalse) {
                eventAddedForTourIndex.value = index;
                isDragAddCompleted.value = true;
                isDragAddCompleted.refresh();
                deleteEventsShowCaseKey.value.reactive;
                ShowCaseWidget.of(context).startShowCase([
                  deleteEventsShowCaseKey.value,
                ]);
              }

              targetItem.refresh();
            }
          }

          // getProcedureDetails(context: context);
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

  callDeleteProcedureEvent(
      {required BuildContext context,
      required Detail detail,
      required Events events}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["procedure_db_id"] = (isAddedPatients.isTrue)
        ? addedPatientProcedureDbId.value
        : (isProcedureView)
            ? procedureDbId
            : box.read(ArgumentConstant.procedureDbId);
    dict["day"] = detail.day;
    dict["event_db_id"] = events.eventDbId;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.deleteProcedureEventApi,
      MethodType.Delete,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        if (response["status_code"] == 200 && response["response"] == true) {
          getSnackBar(
              context: context,
              text: "${events.eventName} Deleted from Day ${detail.day}",
              duration: 600);
          targetItem[deleteIndex.value]
              .events!
              .removeAt(deleteImageIndex.value);
          targetItem.refresh();
          // getProcedureDetails(context: context);
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

  Future<void> callUpdatePatientProcedureEvent({
    required BuildContext context,
    required int index,
    Detail? detail,
    DragItem? dragItem,
    bool isForAddDay = false,
    int day = 0,
  }) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["patient_procedure_db_id"] = addedPatientProcedureDbId.value;

    dict["day"] = (isForAddDay) ? day : detail!.day;
    dict["event_db_id"] =
        (isForAddDay) ? "624420e970c14f56956f3d18" : dragItem!.id;
    dict["event_name"] = (isForAddDay) ? "Meds" : dragItem!.name;
    dict["additional_instruction"] = "";
    dict["show_on_calendar"] = false;

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updatePatientProcedure +
          "?patient_procedure_db_id=${addedPatientProcedureDbId.value}&event_db_id=${(isForAddDay) ? "624420e970c14f56956f3d18" : dragItem!.id}&day=${(isForAddDay) ? day : detail!.day}",
      MethodType.Put,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          if (isForAddDay) {
            targetItem.add(Detail(date: "", day: day, isToday: false, events: [
              Events(
                eventName: "Meds",
                eventDbId: "624420e970c14f56956f3d18",
                additionalInstruction: "",
                uploads: [],
                isVisible: false,
                isActive: true.obs,
                image: getImageById(id: "624420e970c14f56956f3d18").obs,
              )
            ]));
          } else {
            bool isAvailable = false;
            targetItem[index].events!.forEach((element) {
              if (element.image == getImageById(id: dragItem!.id!).obs) {
                isAvailable = true;
              }
            });
            if (!isAvailable) {
              targetItem[index].events!.add(Events(
                  isActive: false.obs,
                  isVisible: true,
                  uploads: [],
                  additionalInstruction: "",
                  eventDbId: dragItem!.id,
                  eventName: dragItem.name,
                  image: getImageById(id: dragItem.id!).obs));
              targetItem.refresh();
            }
          }

          // getProcedureDetails(context: context);
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

  callDeletePatientProcedureEvent(
      {required BuildContext context,
      required Detail detail,
      required Events events}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["patient_procedure_db_id"] = addedPatientProcedureDbId.value;
    dict["day"] = detail.day;
    dict["event_db_id"] = events.eventDbId;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.deletePatientProcedure,
      MethodType.Delete,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        if (response["status_code"] == 200 && response["response"] == true) {
          getSnackBar(
              context: context,
              text: "${events.eventName} Deleted from Day ${detail.day}",
              duration: 600);
          targetItem[deleteIndex.value]
              .events!
              .removeAt(deleteImageIndex.value);
          targetItem.refresh();
          // getProcedureDetails(context: context);
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
                ArgumentConstant.addedPatientName: patientName,
                ArgumentConstant.addedPatientProcedureName:
                    patientProcedureName,
                ArgumentConstant.addedPatientProcedureDbId:
                    addedPatientProcedureDbId.value,
                ArgumentConstant.addedPatientDbId: addedPatientDbId.value,
                ArgumentConstant.procedureDbId: procedureDbId,
              });
          // createProcedureReviewController!
          //     .getPatientProcedure(context: context);
          // Get.back();
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
