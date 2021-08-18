import 'package:davnor_medicare/ui/screens/global/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/global/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:davnor_medicare/ui/screens/global/signup.dart';
import 'package:davnor_medicare/ui/screens/global/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';

import 'constants/route_paths.dart' as routes;

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routes.PatientHomeRoute:
      return MaterialPageRoute(builder: (context) => PatientHomeScreen());
    case routes.TermsAndPolicyRoute:
      return MaterialPageRoute(builder: (context) => TermsAndPolicyScreen());
    case routes.DoctorApplicationInstructionRoute:
      return MaterialPageRoute(
        builder: (context) => DoctorApplicationInstructionScreen(),
      );
    case routes.ForgotPasswordRoute:
      return MaterialPageRoute(
        builder: (context) => ForgotPasswordScreen(),
      );
    case routes.SignupRoute:
      return MaterialPageRoute(
        builder: (context) => SignupScreen(),
      );
    case routes.DoctorHomeRoute:
      return MaterialPageRoute(
        builder: (context) => DoctorHomeScreen(),
      );
    case routes.AdminHomeRoute:
      return MaterialPageRoute(
        builder: (context) => AdminHomeScreen(),
      );
    case routes.PSWDHeadHomeRoute:
      return MaterialPageRoute(
        builder: (context) => PSWDHeadHomeScreen(),
      );
    case routes.PSWDPersonnelHomeRoute:
      return MaterialPageRoute(
        builder: (context) => PSWDPersonnelHomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
