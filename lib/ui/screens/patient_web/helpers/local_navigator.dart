import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/patient_web/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient_web/cons_history.dart';
import 'package:davnor_medicare/ui/screens/patient_web/cons_queue_table.dart';
import 'package:davnor_medicare/ui/screens/patient_web/home.dart';
import 'package:davnor_medicare/ui/screens/patient_web/live_cons.dart';
import 'package:davnor_medicare/ui/screens/patient_web/ma_details.dart';
import 'package:davnor_medicare/ui/screens/patient_web/ma_form.dart';
import 'package:davnor_medicare/ui/screens/patient_web/ma_history.dart';
import 'package:davnor_medicare/ui/screens/patient_web/ma_queue_table.dart';
import 'package:davnor_medicare/ui/screens/patient_web/profile.dart';
import 'package:davnor_medicare/ui/screens/patient_web/verification_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationController navigationController = Get.find();

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: '/patient-web-home',
    );

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.PATIENT_WEB_HOME:
      return _getPageRoute(PatientDashboardScreen());
    case Routes.PATIENT_MA_DETAILS:
      return _getPageRoute(MADescriptionWebScreen());
    case Routes.PATIENT_WEB_CONS_FORM:
      return _getPageRoute(ConsFormWebScreen());
    case Routes.PATIENT_WEB_MA_FORM:
      return _getPageRoute(MAFormWebScreen());
    case Routes.PATIENT_WEB_LIVE_CONS:
      return _getPageRoute(LiveConsWebScreen());
    case Routes.PATIENT_WEB_MA_HISTORY:
      return _getPageRoute(MaHistoryWebScreen());
    case Routes.PATIENT_WEB_CONS_HISTORY:
      return _getPageRoute(ConsHistoryWebScreen());
    case Routes.PATIENT_WEB_PROFILE:
      return _getPageRoute(PatientProfileWebScreen());
    case Routes.Q_CONS_WEB:
      return _getPageRoute(QueueConsTableWebScreen());
    case Routes.Q_MA_WEB:
      return _getPageRoute(QueueMATableWebScreen());
    case Routes.VERIF_REQ_WEB:
      return _getPageRoute(VerificationWebScreen());
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
