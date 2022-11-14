import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/data/NetworkClient.dart';
import 'package:ivf_project/app/models/event_data_model.dart';
import 'package:ivf_project/app/modules/create_procedure_customise/controllers/create_procedure_customise_controller.dart';
import '../../../../main.dart';
import '../../../constants/api_constant.dart';
import '../../../utilities/progress_dialog_utils.dart';
import '../../patient_tracker_screen/controllers/patient_tracker_screen_controller.dart';

class EditEventController extends GetxController {
  CreateProcedureCustomiseController? createProcedureCustomiseController;
  Rx<TextEditingController> eventTypeController = TextEditingController().obs;
  Rx<TextEditingController> eventNameController = TextEditingController().obs;
  Rx<TextEditingController> dayController = TextEditingController().obs;
  Rx<TextEditingController> eventNoteController = TextEditingController().obs;
  RxList<Events> eventDataList = RxList<Events>([]);
  PatientTrackerScreenController? patientTrackerScreenController;
  Events? selectedEvent;
  RxBool isShowOnCalendar = false.obs;
  RxBool hasData = false.obs;
  RxBool isForAddedPatient = false.obs;
  RxString patientProcedureDbId = "".obs;
  String previousDate = DateFormat("dd MMM yyyy").format(DateTime.now());
  String selectedDate = DateFormat("dd MMM yyyy").format(DateTime.now());
  bool isForPatientTracker = false;
  @override
  void onInit() {
    if (Get.arguments != null) {
      isForAddedPatient.value =
          Get.arguments[ArgumentConstant.isForAddedPatient];
      patientProcedureDbId.value =
          Get.arguments[ArgumentConstant.addedPatientProcedureDbId];
      if (Get.arguments[ArgumentConstant.patientReschedulePreviousDate] !=
          null) {
        previousDate =
            Get.arguments[ArgumentConstant.patientReschedulePreviousDate];
        dayController.value.text = previousDate;
      }
      if (Get.arguments[ArgumentConstant.isForPatientTracker] != null) {
        isForPatientTracker =
            Get.arguments[ArgumentConstant.isForPatientTracker];
      }
    }
    if (!isForPatientTracker) {
      Get.lazyPut<CreateProcedureCustomiseController>(
        () => CreateProcedureCustomiseController(),
      );
      createProcedureCustomiseController =
          Get.find<CreateProcedureCustomiseController>();
    } else {
      Get.lazyPut<PatientTrackerScreenController>(
        () => PatientTrackerScreenController(),
      );
      patientTrackerScreenController =
          Get.find<PatientTrackerScreenController>();
    }

    getEventListing(context: Get.context!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getEventListing({required BuildContext context}) {
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
          EventDataModel res = EventDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.events)) {
            res.events!.forEach((element) {
              eventDataList.add(element);
            });
            eventTypeController.value.text = eventDataList[0].title!;
            selectedEvent = eventDataList[0];
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

  callUpdateProcedureEvent({required BuildContext context}) {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    if (isForAddedPatient.isTrue) {
      dict["patient_procedure_db_id"] = patientProcedureDbId.value;
      dict["previous_date"] = previousDate;
      dict["date"] = dayController.value.text;
    } else {
      dict["procedure_db_id"] = box.read(ArgumentConstant.procedureDbId);
      dict["day"] = int.parse(dayController.value.text.trim());
    }
    dict["event_db_id"] = selectedEvent!.id;
    dict["event_name"] = eventNameController.value.text.trim();
    dict["additional_instruction"] = eventNoteController.value.text.trim();
    dict["show_on_calendar"] = isShowOnCalendar.value;

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      (isForAddedPatient.isTrue)
          ? ApiConstant.updatePatientProcedureEventApi
          : ApiConstant.updateProcedureEventApi,
      (isForAddedPatient.isTrue) ? MethodType.Put : MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        if (response["status_code"] == 200 && response["response"] == true) {
          if (!isForPatientTracker) {
            createProcedureCustomiseController!
                .getEventListing(context: context);
          } else {
            patientTrackerScreenController!
                .getProcedureDetails(context: context);

            Get.back();
          }
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
}
