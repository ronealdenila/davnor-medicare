import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';

import 'constants/route_paths.dart' as routes;

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routes.PatientHomeRoute:
      // if we want to have arguments for our screen
      // var userName = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => PatientHomeScreen());
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
