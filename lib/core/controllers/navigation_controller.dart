import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName) {
    //return navigatorKey.currentState!.pushReplacementNamed(routeName);
    //return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/'));
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  //PARA NAA PAY BACK
  Future<void> navigateToWithBack(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArgs(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

//THIS IS FOR ITEMS
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
