import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/ui/screens/global/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/global/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:davnor_medicare/ui/screens/global/signup.dart';
import 'package:davnor_medicare/ui/screens/global/splash.dart';
import 'package:davnor_medicare/ui/screens/global/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_RequestInfo.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';

import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    //SplashUI must be created soon
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/PatientHome', page: () => PatientHomeScreen()),
    GetPage(name: '/ForgotPassword', page: () => ForgotPasswordScreen()),
    GetPage(name: '/TermsAndPolicy', page: () => TermsAndPolicyScreen()),
    GetPage(
        name: '/DoctorApplicationInstruction',
        page: () => DoctorApplicationInstructionScreen()),
    GetPage(name: '/AdminHome', page: () => AdminHomeScreen()),
    GetPage(name: '/DoctorHome', page: () => DoctorHomeScreen()),
    GetPage(name: '/PSWDHeadHome', page: () => PSWDHeadHomeScreen()),
    GetPage(name: '/PSWDPersonnelHome', page: () => PSWDPersonnelHomeScreen()),
    GetPage(name: '/DoctorProfileRoute', page: () => DoctorProfileScreen()),
    GetPage(name: '/MADescriptionRoute', page: () => MADescriptionScreen()),
    GetPage(name: '/MARequestInfoRoute', page: () => MARequestInfoScreen()),
  ];
}
