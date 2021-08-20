import 'package:davnor_medicare/ui/screens/global/authentication.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/login.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/signup.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';

import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    //SplashUI must be created soon
    // GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/', page: () => AuthenticationScreen()),
    // GetPage(name: '/login', page: () => LoginScreen()),
    // GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/patienthome', page: () => PatientHomeScreen()),

  ];
}
