import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
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
    case Routes.CONS_REQ_WEB: //----
      return _getPageRoute(ConsRequestsWeb());
    case Routes.CONS_HISTORY_WEB: //----
      return _getPageRoute(ConsHistoryWeb());
    case Routes.LIVE_CONS_WEB: //----
      return _getPageRoute(LiveConsultationWeb());
    // case Routes.VERIFICATION_REQ_LIST: //----
    //   return _getPageRoute(DocConsHistoryScreen());
    // case Routes.EDIT_DOCTOR:
    //   final DoctorModel passedData = settings.arguments as DoctorModel;
    //   return _getPageRoute(EditDoctorScrenn(passedData: passedData));
    // case Routes.EDIT_PSWD_STAFF:
    //   final PswdModel passedData = settings.arguments as PswdModel;
    //   return _getPageRoute(EditPSWDStaffScrenn(passedData: passedData));
    // case Routes.VERIFICATION_REQ_ITEM:
    //   final VerificationReqModel passedData =
    //       settings.arguments as VerificationReqModel;
    //   return _getPageRoute(VerificationReqItemScreen(passedData: passedData));
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
