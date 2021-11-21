import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/doctor_profile.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/cons_requests.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/home.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/live_cons_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationController navigationController = Get.find();

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: '/doc-web-home',
    );

//DOCTOR ROUTES
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.DOC_WEB_HOME:
      return _getPageRoute(DoctorDashboardScreen());
    case Routes.CONS_REQ_WEB:
      return _getPageRoute(ConsRequestsWeb());
    case Routes.CONS_HISTORY_WEB:
      return _getPageRoute(ConsHistoryWeb());
    case Routes.LIVE_CONS_WEB:
      return _getPageRoute(LiveConsultationWeb());
    case Routes.DOC_WEB_PROFILE:
      return _getPageRoute(DoctorWebProfileScreen());
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
