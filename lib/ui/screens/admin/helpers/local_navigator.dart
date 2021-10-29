import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/admin_profile.dart';
import 'package:davnor_medicare/ui/screens/admin/doctor_list.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/admin/pswd_staff_list.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationController navigationController = Get.find();

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: '/dashboard',
    );

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.DASHBOARD:
      return _getPageRoute(AdminDashboardScreen());
    case Routes.DOCTOR_LIST:
      return _getPageRoute(DoctorListScreen());
    case Routes.PSWD_STAFF_LIST:
      return _getPageRoute(PSWDStaffListScreen());
    case Routes.ADMIN_PROFILE:
      return _getPageRoute(AdminProfileScreen());
    case Routes.VERIFICATION_REQ_LIST:
      return _getPageRoute(VerificationReqListScreen());
    // case Routes.RELEASING_AREA_LIST:
    //   return _getPageRoute(ReleasingAreaListScreen());
    // case Routes.MA_HISTORY_LIST:
    //   return _getPageRoute(MAHistoryList());
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
