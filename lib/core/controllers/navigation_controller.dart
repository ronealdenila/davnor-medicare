import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
    //from puchReplacedNames
  }

  Future<dynamic> navigateToWithArgs(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
}
