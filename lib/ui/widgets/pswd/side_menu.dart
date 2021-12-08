import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PswdPSideMenu extends GetView<MenuController> {
  final MenuController menuController = Get.find();
  final NavigationController navigationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePanelColor,
      child: ListView(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
              ),
            ),
            verticalSpace50,
            ...pswdPSideMenuItemRoutes
                .map((item) => PswdPSideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name!)!) {
                        menuController.changeActiveItemTo(item.name);
                        navigationController.navigateTo(item.route!);
                      }
                    }))
                .toList(),
          ])
        ],
      ),
    );
  }
}

class PswdHeadSideMenu extends GetView<MenuController> {
  final NavigationController navigationController = Get.find();
  final MenuController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePanelColor,
      child: ListView(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
              ),
            ),
            verticalSpace50,
            ...pswdHeadSideMenuItemRoutes
                .map((item) => PswdHeadSideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name!)!) {
                        menuController.changeActiveItemTo(item.name);
                        navigationController.navigateTo(item.route!);
                      }
                    }))
                .toList(),
          ])
        ],
      ),
    );
  }
}
