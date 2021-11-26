import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<void> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToWithArgs(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
}
