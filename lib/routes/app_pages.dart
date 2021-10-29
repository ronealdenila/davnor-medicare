// ignore_for_file: constant_identifier_names
import 'package:davnor_medicare/ui/screens/admin/admin_profile.dart';
import 'package:davnor_medicare/ui/screens/admin/doctor_list.dart';
import 'package:davnor_medicare/ui/screens/admin/doctor_registration.dart';
import 'package:davnor_medicare/ui/screens/admin/edit_doctor.dart';
import 'package:davnor_medicare/ui/screens/admin/edit_pswd_staff.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/admin/pswd_staff_list.dart';
import 'package:davnor_medicare/ui/screens/admin/pswd_staff_registration.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_item.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_list.dart';
import 'package:davnor_medicare/ui/screens/auth/change_password.dart';
import 'package:davnor_medicare/ui/screens/auth/doctor_application_guide.dart';
import 'package:davnor_medicare/ui/screens/auth/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/auth/login.dart';
import 'package:davnor_medicare/ui/screens/auth/signup.dart';
import 'package:davnor_medicare/ui/screens/auth/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form3.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history_info.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat_info.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history_info.dart';
import 'package:davnor_medicare/ui/screens/patient/notification_feed.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_cons.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma_table.dart';
import 'package:davnor_medicare/ui/screens/patient/verification.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/for_approval_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/accepted_ma_req.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/on_progress_req_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/on_progress_req_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/releasing_area_item.dart';
import 'package:davnor_medicare/ui/screens/splash.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //Note(R): diria nata mag set sa initial screen na atong gusto itest
  static const INITIAL = Routes.PSWD_PERSONNEL_HOME;
                                

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),

    //Auth
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_POLICY,
      page: () => TermsAndPolicyScreen(),
    ),
    GetPage(
      name: _Paths.DOCTOR_APPLICATION_GUIDE,
      page: () => DoctorApplicationGuideScreen(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordScreen(),
    ),

    //Patient
    GetPage(
      name: _Paths.PATIENT_HOME,
      page: () => PatientHomeScreen(),
    ),
    GetPage(
      name: _Paths.MA_DESCRIPTION,
      page: () => MADescriptionScreen(),
    ),
    GetPage(
      name: _Paths.MA_REQUEST_INFO,
      page: () => MAHistoryInfoScreen(),
    ),
    GetPage(
      name: _Paths.CONS_FORM,
      page: () => ConsFormScreen(),
    ),
    GetPage(
      name: _Paths.CONS_FORM2,
      page: () => ConsForm2Screen(),
    ),
    GetPage(
      name: _Paths.CONS_FORM3,
      page: () => ConsForm3Screen(),
    ),
    GetPage(
      name: _Paths.PATIENT_CONS_HISTORY_INFO,
      page: () => PatientConsHistoryInfoScreen(),
    ),
    GetPage(
      name: _Paths.ARTICLE_ITEM,
      page: () => ArticleItemScreen(),
    ),
    GetPage(
      name: _Paths.QUEUE_CONS,
      page: () => QueueConsScreen(),
    ),
    GetPage(
      name: _Paths.QUEUE_MA,
      page: () => QueueMAScreen(),
    ),
    GetPage(
      name: _Paths.MA_FORM,
      page: () => MAFormScreen(),
    ),
    GetPage(
      name: _Paths.MA_FORM2,
      page: () => MAForm2Screen(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => VerificationScreen(),
    ),
    GetPage(
      name: _Paths.CONS_HISTORY,
      page: () => ConsHistoryScreen(),
    ),
    GetPage(
      name: _Paths.MA_HISTORY,
      page: () => MAHistoryScreen(),
    ),
    GetPage(
      name: _Paths.LIVE_CHAT,
      page: () => LiveChatScreen(),
    ),
    GetPage(
      name: _Paths.QUEUE_MA_TABLE,
      page: () => QueueMATableScreen(),
    ),
    GetPage(
      name: _Paths.LIVE_CHAT_INFO,
      page: () => LiveChatInfoScreen(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_FEED,
      page: () => NotificationFeedScreen(),
    ),

    //Doctor
    GetPage(
      name: _Paths.DOCTOR_HOME,
      page: () => DoctorHomeScreen(),
    ),
    GetPage(
      name: _Paths.DOCTOR_PROFILE,
      page: () => DoctorProfileScreen(),
    ),
    GetPage(
      name: _Paths.DOCTOR_HISTORY_INFO,
      page: () => HistoryInfoScreen(),
    ),
    GetPage(
      name: _Paths.DOC_CONS_HISTORY,
      page: () => DocConsHistoryScreen(),
    ),
    GetPage(
      name: _Paths.DOC_LIVE_CONS_INFO,
      page: () => LiveConsInfoScreen(),
    ),
    GetPage(
      name: _Paths.DOC_CONS_REQ_INFO,
      page: () => ConsReqInfoScreen(),
    ),

    //PSWD
    GetPage(
      name: _Paths.PSWD_HEAD_HOME,
      page: () => PSWDHeadHomeScreen(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => PswdHeadDashboardScreen(),
    ),
    GetPage(
      name: _Paths.PSWD_PERSONNEL_HOME,
      page: () => PSWDPersonnelHome(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => PswdPDashboardScreen(),
    ),
    GetPage(
      name: _Paths.MA_REQ_LIST,
      page: () => MARequestListScreen(),
    ),
    GetPage(
      name: _Paths.MA_REQ_ITEM,
      page: () => MARequestItemScreen(),
    ),

    GetPage(
      name: _Paths.ON_PROGRESS_REQ_ITEM,
      page: () => MARequestItemScreen(),
    ),
    GetPage(
      name: _Paths.ON_PROGRESS_REQ_LIST,
      page: () => OnProgressReqListScreen(),
    ),
    GetPage(
      name: _Paths.PSWD_ACCEPTED_MA_REQ,
      page: () => AcceptedMARequestScreen(),
    ),
    GetPage(
      name: _Paths.MA_HISTORY_ITEM,
      page: () => MAHistoryItemScreen(),
    ),
    GetPage(
      name: _Paths.RELEASING_AREA_ITEM,
      page: () => ReleasingAreaItemScreen(),
    ),
    GetPage(
      name: _Paths.ON_PROGRESS_REQ_ITEM,
      page: () => OnProgressReqItemScreen(),
    ),
    GetPage(
      name: _Paths.FOR_APPROVAL_ITEM,
      page: () => ForApprovalItemScreen(),
    ),

    //Admin
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => AdminHomeScreen(),
    ),
    GetPage(
      name: _Paths.DOCTOR_REGISTRATION,
      page: () => DoctorRegistrationScreen(),
    ),
    GetPage(
      name: _Paths.PSWD_STAFF_REGISTRATION,
      page: () => PSWDStaffRegistrationScreen(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_REQ_ITEM,
      page: () => VerificationReqItemScreen(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_REQ_LIST,
      page: () => VerificationReqListScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => AdminProfileScreen(),
    ),
    GetPage(
      name: _Paths.EDIT_PSWD_STAFF,
      page: () => EditPSWDStaffScrenn(),
    ),
    GetPage(
      name: _Paths.DOCTOR_LIST,
      page: () => DoctorListScreen(),
    ),
    GetPage(
      name: _Paths.PSWD_STAFF_LIST,
      page: () => PSWDStaffListScreen(),
    ),
  ];
}
