import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

const String baseUrl = "https://api.kanu.app/api/v1/";

class ApiConstant {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static const loginApi = "login/";
  static const profileCheckApi = "profile/";
  static const createAccountApi = "account/create/";
  static const procedureListingApi = "procedures/";
  static const procedureDetailsApi = "procedures/";
  static const patientProcedureApi = "patients/procedure/";
  static const eventCallApi = "events/";
  static const createNewProcedureApi = "procedures/";
  static const updateProcedureEventApi = "procedure/events/";
  static const deleteProcedureEventApi = "procedure/events/";
  static const updateProcedureApi = "procedures/";
  static const deleteProcedureApi = "procedures/";
  static const addPatientApi = "patients/";
  static const getPatientProcedureApi = "patients/procedure/";
  static const patientProcedureAssignmentApi = "patients/procedure/";
  static const getProcedureEventApi = "patients/procedure/";
  static const patientsListApi = "patients/";
  static const updatePatientProcedureEventApi = "patients/procedure/";
  static const patientMyScheduleApi = "patients/procedure/";
  static const patientContacts = "patients/contacts/";
  static const terminateProcedure = "terminate/procedure/";
  static const updateMsCycleDate = "patients/procedure/update/";
  static const updatePatientProcedure = "patients/procedure/update/";
  static const deletePatientProcedure = "patients/procedure/update/";
  static const deletePatientApi = "patients/";
  static const skipProfileUpdate = "profile/update/skip/";

  //tour
  static const getTourStepApi = "app/tour/";
  static const updateTourStepApi = "app/tour/";
}

class ArgumentConstant {
  static String userRole = "userRole";
  static const mobileNumber = "mobileNumber";
  static const phoneCode = "phoneCode";
  static const doctorMobileNumber = "doctorMobileNumber";
  static const token = "token";
  static const userId = "userId";
  static String procedureName = "procedureName";
  static String procedureType = "procedureType";
  static String selectedProcedureModel = "selectedProcedureModel";
  static String procedureId = "procedureId";
  static String procedureDbId = "procedureDbId";
  static String isAccountCreated = "is_account_created";
  static String addedPatientName = "addedPatientName";
  static String addedPatientNumber = "addedPatientNumber";
  static String addedPatientProcedureName = "addedPatientProcedureName";
  static String addedPatientDbId = "addedPatientDbId";
  static String addedPatientProcedureDbId = "addedPatientProcedureDbId";
  static String patientReschedulePreviousDate = "patientReschedulePreviousDate";
  static String isForAddedPatient = "isForAddedPatient";
  static String patientProcedureDbId = "patientProcedureDbId";
  static String patientMobileNumber = "patientMobileNumber";
  static String selectedDate = "selectedDate";
  static String asDoctor = "asDoctor";
  static String asPatient = "asPatient";
  static String fromAssignedProcedure = "fromAssignedProcedure";
  static String isForAddTeam = "isForAddTeam";
  static String isForAddAgent = "isForAddAgent";
  static String isForAddEmbryologist = "isForAddEmbryologist";
  static String isForAddCoPatient = "isForAddCoPatient";
  static String isForPatientTracker = "isForPatientTracker";
  static String getUserDbId = "getUserDbId";
  static String isProcedureView = "isProcedureView";
  static String msCycleStartDate = "msCycleStartDate";
  static String isFormsCycleStartDateUpdate = "isFormsCycleStartDateUpdate";
  static String isForEditEventFromPatientTracker =
      "isForEditEventFromPatientTracker";
  static String isNavigateToPatientsScreen = "isNavigateToPatientsScreen";
  static String isNavigateToProcedureScreen = "isNavigateToProcedureScreen";
  static String doctorName = "doctorName";
  static String patientName = "patientName";

  //showcase constants
  static String isAddPatientShowed = "isAddPatientShowed";
  static String isMcDateShowCaseShowed = "isMcDateShowCaseShowed";
  static String isEditProcedureShowCaseShowed = "isEditProcedureShowCaseShowed";
  static String isProcedureShowCaseShowed = "isProcedureShowCaseShowed";
  static String customiseProcedureShowCaseShowed =
      "customiseProcedureShowCaseShowed";

  static String tourStep1Started = "tourStep1Started";
  static String tourStep1Completed = "tourStep1Completed";
  static String tourStep2Started = "tourStep2Started";
  static String tourStep2Completed = "tourStep2Completed";
  static String tourStep3Started = "tourStep3Started";
  static String tourStep3Completed = "tourStep3Completed";
  static String allTourStepsJustCompleted = "allTourStepsJustCompleted";
}

String getImageById({required String id}) {
  switch (id) {
    case "624420e970c14f56956f3d18":
      return "assets/capsul.svg";

    case "624420e970c14f56956f3d19":
      return "assets/injection.svg";
    case "624420e970c14f56956f3d1a":
      return "assets/sonar_icon.svg";
    case "624420e970c14f56956f3d1b":
      return "assets/blood_test.svg";
    case "624420e970c14f56956f3d1c":
      return "assets/covid_test.svg";
    case "624420e970c14f56956f3d1d":
      return "assets/egg02.svg";
    default:
      return "assets/capsul.svg";
  }
}

class Role {
  static const String doctor = "doctor";
  static const String patient = "patient";
  static const String agent = "agent";
}

Widget getNeumorphicButton(
    {required String text,
    required double height,
    required double width,
    required Color textColor,
    required Color backColor}) {
  return Neumorphic(
    style: NeumorphicStyle(
      color: backColor.withOpacity(0.08),
    ),
    child: Container(
      height: MySize.getHeight(height),
      width: MySize.getWidth(width),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: MySize.getHeight(14)),
      ),
    ),
  );
}
