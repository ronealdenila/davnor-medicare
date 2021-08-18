import 'package:davnor_medicare/ui/screens/global/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:davnor_medicare/ui/screens/global/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';

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
          builder: (context) => DoctorApplicationInstructionScreen());
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
