// ignore_for_file: constant_identifier_names
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  //Splash
  static const SPLASH = '/';

  //Auth
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const TERMS_AND_POLICY = _Paths.TERMS_AND_POLICY;
  static const DOCTOR_APPLICATION_GUIDE = _Paths.DOCTOR_APPLICATION_GUIDE;

  //Patient
  static const PATIENT_HOME = _Paths.PATIENT_HOME;
  static const MA_DESCRIPTION = _Paths.MA_DESCRIPTION;
  static const MA_REQUEST_INFO = _Paths.MA_REQUEST_INFO;
  static const CONS_FORM = _Paths.CONS_FORM;
  static const CONS_FORM2 = _Paths.CONS_FORM2;
  static const CONS_FORM3 = _Paths.CONS_FORM3;
  static const PATIENT_CONS_HISTORY_INFO = _Paths.PATIENT_CONS_HISTORY_INFO;
  static const ARTICLE_ITEM = _Paths.ARTICLE_ITEM;
  static const QUEUE_CONS = _Paths.QUEUE_CONS;
  static const QUEUE_MA = _Paths.QUEUE_MA;
  static const QUEUE_MA_TABLE = _Paths.QUEUE_MA_TABLE;
  static const MA_FORM = _Paths.MA_FORM;
  static const MA_FORM2 = _Paths.MA_FORM2;
  static const VERIFICATION = _Paths.VERIFICATION;
  static const CONS_HISTORY = _Paths.CONS_HISTORY;
  static const MA_HISTORY = _Paths.MA_HISTORY;
  static const LIVE_CHAT = _Paths.LIVE_CHAT;

  //Doctor
  static const DOCTOR_HOME = _Paths.DOCTOR_HOME;
  static const DOCTOR_PROFILE = _Paths.DOCTOR_PROFILE;
  static const DOCTOR_HISTORY_INFO = _Paths.DOCTOR_HISTORY_INFO;
  static const DOC_CONS_HISTORY = _Paths.DOC_CONS_HISTORY;

  //PSWD
  static const PSWD_HEAD_HOME = _Paths.PSWD_HEAD_HOME;
  static const PSWD_PERSONNEL_HOME = _Paths.PSWD_PERSONNEL_HOME;
  static const DASHBOARD = _Paths.DASHBOARD;

  static const ON_PROGRESS_REQ_LIST = _Paths.ON_PROGRESS_REQ_LIST;
  static const ON_PROGRESS_REQ_ITEM = _Paths.ON_PROGRESS_REQ_ITEM;
  static const PSWD_ACCEPTED_MA_REQ = _Paths.PSWD_ACCEPTED_MA_REQ;
  static const MA_HISTORY_ITEM = _Paths.MA_HISTORY_ITEM;
  static const MA_HISTORY_LIST = _Paths.MA_HISTORY_LIST;
  static const RELEASING_AREA_LIST = _Paths.RELEASING_AREA_LIST;
  static const RELEASING_AREA_ITEM = _Paths.RELEASING_AREA_ITEM;
  static const FOR_APPROVAL_ITEM = _Paths.FOR_APPROVAL_ITEM;

  //Admin
  static const ADMIN_HOME = _Paths.ADMIN_HOME;
  static const DOCTOR_REGISTRATION = _Paths.DOCTOR_REGISTRATION;
  static const PSWD_STAFF_REGISTRATION = _Paths.PSWD_STAFF_REGISTRATION;
  static const VERIFICATION_REQ_ITEM = _Paths.VERIFICATION_REQ_ITEM;
  static const VERIFICATION_REQ_LIST = _Paths.VERIFICATION_REQ_LIST;
  static const ADMIN_PROFILE = _Paths.ADMIN_PROFILE;
  static const EDIT_DOCTOR = _Paths.EDIT_DOCTOR;
  static const EDIT_PSWD_STAFF = _Paths.EDIT_PSWD_STAFF;
}

abstract class _Paths {
  //Splash
  static const SPLASH = '/';

  //Auth
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const TERMS_AND_POLICY = '/terms-and-policy';
  static const DOCTOR_APPLICATION_GUIDE = '/doctor-application-guide';

  //Patient
  static const PATIENT_HOME = '/home';
  static const MA_DESCRIPTION = '/MA-description';
  static const MA_REQUEST_INFO = '/MA-request-info';
  static const CONS_FORM = '/cons-form';
  static const CONS_FORM2 = '/cons-form2';
  static const CONS_FORM3 = '/cons-form3';
  static const PATIENT_CONS_HISTORY_INFO = '/cons-history-info';
  static const ARTICLE_ITEM = '/article-item';
  static const QUEUE_CONS = '/queue-cons';
  static const QUEUE_MA = '/queue-MA';
  static const QUEUE_MA_TABLE = '/queue-MA-table';
  static const MA_FORM = '/MA-form';
  static const MA_FORM2 = '/MA-form2';
  static const VERIFICATION = '/verification';
  static const CONS_HISTORY = '/cons-history';
  static const MA_HISTORY = '/MA-history';
  static const LIVE_CHAT = '/live-chat';

  //Doctor
  static const DOCTOR_HOME = '/home';
  static const DOCTOR_PROFILE = '/profile';
  static const DOCTOR_HISTORY_INFO = '/history-info';
  static const DOC_CONS_HISTORY = '/cons-history';

  //PSWD
  static const PSWD_HEAD_HOME = '/pswd-head-home';
  static const PSWD_PERSONNEL_HOME = '/pswd-home';
  static const DASHBOARD = '/dashboard';

  static const ON_PROGRESS_REQ_ITEM = '/OnProgressReqItemScreen';
  static const ON_PROGRESS_REQ_LIST = '/OnProgressReqListScreen';
  static const PSWD_ACCEPTED_MA_REQ = '/AcceptedMARequestScreen';
  static const MA_HISTORY_ITEM = '/MAHistoryItemScreen';
  static const MA_HISTORY_LIST = '/MAHistoryListScreen';
  static const RELEASING_AREA_ITEM = '/ReleasingAreaItemScreen';
  static const RELEASING_AREA_LIST = '/ReleasingAreaListScreen';
  static const FOR_APPROVAL_ITEM = '/ForApprovalItemScreen';

  //Admin
  static const ADMIN_HOME = '/admin-home';
  static const DOCTOR_REGISTRATION = '/adm-doctor-registration';
  static const PSWD_STAFF_REGISTRATION = '/adm-pswd-staff-registration';
  static const VERIFICATION_REQ_ITEM = '/adm-verification-req-item';
  static const VERIFICATION_REQ_LIST = '/adm-verification-req-list';
  static const ADMIN_PROFILE = '/admin-profile';
  static const EDIT_DOCTOR = '/edit-doctor';
  static const EDIT_PSWD_STAFF = '/edit-pswd-staff';
}
