import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/on_progress_req_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/on_progress_req_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/releasing_area_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/releasing_area_list.dart';
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
      return _getPageRoute(PswdPDashboardScreen());
    case Routes.MA_REQ_LIST:
      return _getPageRoute(MARequestListScreen());
    case Routes.ON_PROGRESS_REQ_LIST:
      return _getPageRoute(OnProgressReqListScreen());
    case Routes.RELEASING_AREA_LIST:
      return _getPageRoute(ReleasingAreaListScreen());
    case Routes.MA_HISTORY_LIST:
      return _getPageRoute(MAHistoryList());
    case Routes.MA_HISTORY_ITEM:
      final MAHistoryModel passedData = settings.arguments as MAHistoryModel;
      return _getPageRoute(MAHistoryItemScreen(passedData: passedData));
    case Routes.MA_REQ_ITEM:
      final MARequestModel passedData = settings.arguments as MARequestModel;
      return _getPageRoute(MARequestItemScreen(passedData: passedData));
    case Routes.ON_PROGRESS_REQ_ITEM:
      final OnProgressMAModel passedData =
          settings.arguments as OnProgressMAModel;
      return _getPageRoute(OnProgressReqItemScreen(passedData: passedData));
    case Routes.RELEASING_AREA_ITEM:
      final OnProgressMAModel passedData =
          settings.arguments as OnProgressMAModel;
      return _getPageRoute(ReleasingAreaItemScreen(passedData: passedData));
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
