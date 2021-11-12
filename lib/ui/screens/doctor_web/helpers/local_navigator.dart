import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_item.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_list.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/calling.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/cons_req_info.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/cons_req_item.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/dcons_history_item.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/home.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/live_cons_info.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/profile.dart';
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
    case Routes.DOCTOR_LIST: //----
      return _getPageRoute(ArticleListScreen());
    case Routes.DOCTOR_LIST: //----
      return _getPageRoute(ArticleItemScreen());
    case Routes.PSWD_STAFF_LIST: //----
      return _getPageRoute(CallPatientScreen());
    case Routes.ADMIN_PROFILE: //----
      return _getPageRoute(HistoryInfoScreen());
    case Routes.VERIFICATION_REQ_LIST: //----
      return _getPageRoute(DocConsHistoryScreen());
    case Routes.DOCTOR_REGISTRATION: //----
      return _getPageRoute(ConsReqInfoScreen());
    case Routes.PSWD_STAFF_REGISTRATION: //----
      return _getPageRoute(ConsRequestItemScreen());
    case Routes.DISABLED_DOCTORS: //----
      return _getPageRoute(DoctorConsHistoryItemScreen());
    case Routes.DISABLED_PSWD_STAFF: //----
      return _getPageRoute(LiveConsInfoScreen());
    case Routes.DISABLED_DOCTORS: //----
      return _getPageRoute(LiveConsultationScreen());
    case Routes.DISABLED_PSWD_STAFF: //----
      return _getPageRoute(DoctorProfileScreen());
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
