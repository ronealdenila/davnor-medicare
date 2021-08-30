import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/auth/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/auth/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/auth/login.dart';
import 'package:davnor_medicare/ui/screens/auth/signup.dart';
import 'package:davnor_medicare/splash.dart';
import 'package:davnor_medicare/ui/screens/auth/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/doctor/history_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form3.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history_info.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_cons.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma.dart';
import 'package:davnor_medicare/ui/screens/patient/verification.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_request_info.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';

import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    //SplashUI must be created soon
    GetPage(name: '/', page: () => const SplashScreen()),

    //Auth
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
    ),
    GetPage(
      name: '/ForgotPassword',
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: '/TermsAndPolicy',
      page: () => TermsAndPolicyScreen(),
    ),
    GetPage(
      name: '/DoctorApplicationInstruction',
      page: () => DoctorApplicationInstructionScreen(),
    ),

    //Patient
    GetPage(
      name: '/PatientHome',
      page: () => PatientHomeScreen(),
    ),
    GetPage(
      name: '/MADescriptionRoute',
      page: () => MADescriptionScreen(),
    ),
    GetPage(
      name: '/MARequestInfoRoute',
      page: () => MARequestInfoScreen(),
    ),
    GetPage(
      name: '/ConsForm',
      page: () => ConsFormScreen(),
    ),
    GetPage(
      name: '/ConsForm2',
      page: () => ConsForm2Screen(),
    ),
    GetPage(
      name: '/ConsForm3',
      page: () => ConsForm3Screen(),
    ),
    GetPage(
      name: '/PatientConsHistoryInfo',
      page: () => PatientConsHistoryInfoScreen(),
    ),
    GetPage(
      name: '/ArticleItem',
      page: () => ArticleItemScreen(),
    ),
    GetPage(
      name: '/QueueCons',
      page: () => QueueConsScreen(),
    ),
    GetPage(
      name: '/QueueMA',
      page: () => QueueMAScreen(),
    ),
    GetPage(
      name: '/MAForm',
      page: () => MAFormScreen(),
    ),
    GetPage(
      name: '/MAForm2',
      page: () => MAForm2Screen(),
    ),
    GetPage(
      name: '/Verification',
      page: () => VerificationScreen(),
    ),
    GetPage(name: '/ConsHistory', page: () => ConsHistoryScreen()),
    GetPage(name: '/MAHistory', page: () => MAHistoryScreen()),

    //Doctor
    GetPage(
      name: '/DoctorHome',
      page: () => DoctorHomeScreen(),
    ),
    GetPage(
      name: '/DoctorProfileRoute',
      page: () => DoctorProfileScreen(),
    ),
    GetPage(
      name: '/DoctorHistoryInfo',
      page: () => HistoryInfoScreen(),
    ),
    GetPage(name: '/DocConsHistory', page: () => DocConsHistoryScreen()),

    //PSWD
    GetPage(
      name: '/PSWDHeadHome',
      page: () => PSWDHeadHomeScreen(),
    ),
    GetPage(
      name: '/PSWDPersonnelHome',
      page: () => PSWDPersonnelHomeScreen(),
    ),

    //Admin
    GetPage(
      name: '/AdminHome',
      page: () => AdminHomeScreen(),
    ),
  ];
}
