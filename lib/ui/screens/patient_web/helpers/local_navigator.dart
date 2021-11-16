import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/patient_web/home.dart';
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
      return _getPageRoute(PatientDashboardScreen());
    // case Routes.FOR_APPROVAL_LIST:
    //   return _getPageRoute(ForApprovalListScreen());
    // case Routes.ON_PROGRESS_REQ_LIST:
    //   return _getPageRoute(OnProgressReqListScreen());
    // case Routes.RELEASING_AREA_LIST:
    //   return _getPageRoute(ReleasingAreaListScreen());
    // case Routes.MA_HISTORY_LIST:
    //   return _getPageRoute(MAHistoryList());
    // case Routes.MA_HISTORY_ITEM:
    //   final MAHistoryModel passedData = settings.arguments as MAHistoryModel;
    //   return _getPageRoute(MAHistoryItemScreen(passedData: passedData));

    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
