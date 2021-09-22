import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
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
      return _getPageRoute(PswdHeadDashboardScreen());
    // case Routes.ON_PROGRESS_REQ_LIST:
    //   return _getPageRoute(OnProgressReqListScreen());
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
