import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/auth/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/auth/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/auth/login.dart';
import 'package:davnor_medicare/ui/screens/auth/signup.dart';
import 'package:davnor_medicare/ui/screens/auth/splash.dart';
import 'package:davnor_medicare/ui/screens/auth/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/doctor/history_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form3.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_cons.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma.dart';
import 'package:davnor_medicare/ui/screens/patient/verification.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_request_info.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';

import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    //SplashUI must be created soon
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/PatientHome', page: () => PatientHomeScreen()),
    GetPage(name: '/ForgotPassword', page: () => ForgotPasswordScreen()),
    GetPage(name: '/TermsAndPolicy', page: () => const TermsAndPolicyScreen()),
    GetPage(
        name: '/DoctorApplicationInstruction',
        page: () => DoctorApplicationInstructionScreen()),
    GetPage(name: '/AdminHome', page: () => AdminHomeScreen()),
    GetPage(name: '/DoctorHome', page: () => DoctorHomeScreen()),
    GetPage(name: '/PSWDHeadHome', page: () => PSWDHeadHomeScreen()),
    GetPage(name: '/PSWDPersonnelHome', page: () => PSWDPersonnelHomeScreen()),
    GetPage(name: '/DoctorProfileRoute', page: () => DoctorProfileScreen()),
    GetPage(name: '/DoctorHistoryInfo', page: () => HistoryInfoScreen()),
    GetPage(
        name: '/MADescriptionRoute', page: () => const MADescriptionScreen()),
    GetPage(
        name: '/MARequestInfoRoute', page: () => const MARequestInfoScreen()),

    GetPage(name: '/ConsForm', page: () => ConsFormScreen()),
    GetPage(name: '/ConsForm2', page: () => const ConsForm2Screen()),
    GetPage(name: '/ConsForm3', page: () => const ConsForm3Screen()),
    GetPage(name: '/Verification', page: () => const VerifyAccountScreen()),
    GetPage(name: '/QueueCons', page: () => const QueueConsScreen()),
    GetPage(name: '/QueueMA', page: () => const QueueMAScreen()),
  ];
}
