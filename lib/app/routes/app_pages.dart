import 'package:get/get.dart';

import '../modules/add_new_patient_screen/bindings/add_new_patient_screen_binding.dart';
import '../modules/add_new_patient_screen/views/add_new_patient_screen_view.dart';
import '../modules/assign_procedure_screen/bindings/assign_procedure_screen_binding.dart';
import '../modules/assign_procedure_screen/views/assign_procedure_screen_view.dart';
import '../modules/assigned_procedure_page_2/bindings/assigned_procedure_page_2_binding.dart';
import '../modules/assigned_procedure_page_2/views/assigned_procedure_page_2_view.dart';
import '../modules/contact_screen/bindings/contact_screen_binding.dart';
import '../modules/contact_screen/views/contact_screen_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/create_account_patient/bindings/create_account_patient_binding.dart';
import '../modules/create_account_patient/views/create_account_patient_view.dart';
import '../modules/create_procedure_customise/bindings/create_procedure_customise_binding.dart';
import '../modules/create_procedure_customise/views/create_procedure_customise_view.dart';
import '../modules/create_procedure_define/bindings/create_procedure_define_binding.dart';
import '../modules/create_procedure_define/views/create_procedure_define_view.dart';
import '../modules/create_procedure_review/bindings/create_procedure_review_binding.dart';
import '../modules/create_procedure_review/views/create_procedure_review_view.dart';
import '../modules/doctor_my_profile/bindings/doctor_my_profile_binding.dart';
import '../modules/doctor_my_profile/views/doctor_my_profile_view.dart';
import '../modules/doctor_profile/bindings/doctor_profile_binding.dart';
import '../modules/doctor_profile/views/doctor_profile_view.dart';
import '../modules/doctor_setting/bindings/doctor_setting_binding.dart';
import '../modules/doctor_setting/views/doctor_setting_view.dart';
import '../modules/doctor_support_screen/bindings/doctor_support_screen_binding.dart';
import '../modules/doctor_support_screen/views/doctor_support_screen_view.dart';
import '../modules/edit_event/bindings/edit_event_binding.dart';
import '../modules/edit_event/views/edit_event_view.dart';
import '../modules/ftue/bindings/ftue_binding.dart';
import '../modules/ftue/views/ftue_view.dart';
import '../modules/ftue_patient/bindings/ftue_patient_binding.dart';
import '../modules/ftue_patient/views/ftue_patient_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_screen/bindings/home_screen_binding.dart';
import '../modules/home_screen/views/home_screen_view.dart';
import '../modules/notification_redirection_screen/bindings/notification_redirection_screen_binding.dart';
import '../modules/notification_redirection_screen/views/notification_redirection_screen_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/patient_calendar/bindings/patient_calendar_binding.dart';
import '../modules/patient_calendar/views/patient_calendar_view.dart';
import '../modules/patient_home/bindings/patient_home_binding.dart';
import '../modules/patient_home/views/patient_home_view.dart';
import '../modules/patient_home_screen/bindings/patient_home_screen_binding.dart';
import '../modules/patient_home_screen/views/patient_home_screen_view.dart';
import '../modules/patient_my_profile/bindings/patient_my_profile_binding.dart';
import '../modules/patient_my_profile/views/patient_my_profile_view.dart';
import '../modules/patient_my_reports/bindings/patient_my_reports_binding.dart';
import '../modules/patient_my_reports/views/patient_my_reports_view.dart';
import '../modules/patient_my_schedule/bindings/patient_my_schedule_binding.dart';
import '../modules/patient_my_schedule/views/patient_my_schedule_view.dart';
import '../modules/patient_setting/bindings/patient_setting_binding.dart';
import '../modules/patient_setting/views/patient_setting_view.dart';
import '../modules/patient_tracker_add_prescription/bindings/patient_tracker_add_prescription_binding.dart';
import '../modules/patient_tracker_add_prescription/views/patient_tracker_add_prescription_view.dart';
import '../modules/patient_tracker_contacts_view/bindings/patient_tracker_contacts_view_binding.dart';
import '../modules/patient_tracker_contacts_view/views/patient_tracker_contacts_view_view.dart';
import '../modules/patient_tracker_profile_view/bindings/patient_tracker_profile_view_binding.dart';
import '../modules/patient_tracker_profile_view/views/patient_tracker_profile_view_view.dart';
import '../modules/patient_tracker_reports_view/bindings/patient_tracker_reports_view_binding.dart';
import '../modules/patient_tracker_reports_view/views/patient_tracker_reports_view_view.dart';
import '../modules/patient_tracker_schedule_view/bindings/patient_tracker_schedule_view_binding.dart';
import '../modules/patient_tracker_schedule_view/views/patient_tracker_schedule_view_view.dart';
import '../modules/patient_tracker_screen/bindings/patient_tracker_screen_binding.dart';
import '../modules/patient_tracker_screen/views/patient_tracker_screen_view.dart';
import '../modules/patient_tracker_terminate/bindings/patient_tracker_terminate_binding.dart';
import '../modules/patient_tracker_terminate/views/patient_tracker_terminate_view.dart';
import '../modules/patients/bindings/patients_binding.dart';
import '../modules/patients/views/patients_view.dart';
import '../modules/patients_profile/bindings/patients_profile_binding.dart';
import '../modules/patients_profile/views/patients_profile_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/procudures/bindings/procudures_binding.dart';
import '../modules/procudures/views/procudures_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms_usages/bindings/terms_usages_binding.dart';
import '../modules/terms_usages/views/terms_usages_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.FTUE,
      page: () => FtueView(),
      binding: FtueBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_PROFILE,
      page: () => DoctorProfileView(),
      binding: DoctorProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.PATIENTS,
      page: () => PatientsView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: _Paths.PROCUDURES,
      page: () => ProcuduresView(),
      binding: ProcuduresBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROCEDURE_DEFINE,
      page: () => CreateProcedureDefineView(),
      binding: CreateProcedureDefineBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROCEDURE_CUSTOMISE,
      page: () => CreateProcedureCustomiseView(),
      binding: CreateProcedureCustomiseBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EVENT,
      page: () => EditEventView(),
      binding: EditEventBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROCEDURE_REVIEW,
      page: () => CreateProcedureReviewView(),
      binding: CreateProcedureReviewBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_SCREEN,
      page: () => PatientTrackerScreenView(),
      binding: PatientTrackerScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_SCREEN,
      page: () => ContactScreenView(),
      binding: ContactScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_PATIENT_SCREEN,
      page: () => AddNewPatientScreenView(),
      binding: AddNewPatientScreenBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGN_PROCEDURE_SCREEN,
      page: () => AssignProcedureScreenView(),
      binding: AssignProcedureScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT_PATIENT,
      page: () => CreateAccountPatientView(),
      binding: CreateAccountPatientBinding(),
    ),
    GetPage(
      name: _Paths.FTUE_PATIENT,
      page: () => FtuePatientView(),
      binding: FtuePatientBinding(),
    ),
    GetPage(
      name: _Paths.PATIENTS_PROFILE,
      page: () => PatientsProfileView(),
      binding: PatientsProfileBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_HOME_SCREEN,
      page: () => PatientHomeScreenView(),
      binding: PatientHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_HOME,
      page: () => PatientHomeView(),
      binding: PatientHomeBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_MY_SCHEDULE,
      page: () => PatientMyScheduleView(),
      binding: PatientMyScheduleBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_MY_REPORTS,
      page: () => PatientMyReportsView(),
      binding: PatientMyReportsBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_CALENDAR,
      page: () => PatientCalendarView(),
      binding: PatientCalendarBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_SETTING,
      page: () => PatientSettingView(),
      binding: PatientSettingBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_SETTING,
      page: () => DoctorSettingView(),
      binding: DoctorSettingBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_ADD_PRESCRIPTION,
      page: () => PatientTrackerAddPrescriptionView(),
      binding: PatientTrackerAddPrescriptionBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_TERMINATE,
      page: () => PatientTrackerTerminateView(),
      binding: PatientTrackerTerminateBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGNED_PROCEDURE_PAGE_2,
      page: () => AssignedProcedurePage2View(),
      binding: AssignedProcedurePage2Binding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_PROFILE_VIEW,
      page: () => PatientTrackerProfileViewView(),
      binding: PatientTrackerProfileViewBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_SCHEDULE_VIEW,
      page: () => PatientTrackerScheduleViewView(),
      binding: PatientTrackerScheduleViewBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_REPORTS_VIEW,
      page: () => PatientTrackerReportsViewView(),
      binding: PatientTrackerReportsViewBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_TRACKER_CONTACTS_VIEW,
      page: () => PatientTrackerContactsViewView(),
      binding: PatientTrackerContactsViewBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_MY_PROFILE,
      page: () => DoctorMyProfileView(),
      binding: DoctorMyProfileBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_SUPPORT_SCREEN,
      page: () => DoctorSupportScreenView(),
      binding: DoctorSupportScreenBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_USAGES,
      page: () => TermsUsagesView(),
      binding: TermsUsagesBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_MY_PROFILE,
      page: () => PatientMyProfileView(),
      binding: PatientMyProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_REDIRECTION_SCREEN,
      page: () => const NotificationRedirectionScreenView(),
      binding: NotificationRedirectionScreenBinding(),
    ),
  ];
}
