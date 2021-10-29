import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSideMenu extends GetView<AdminMenuController> {
  final NavigationController navigationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePanelColor,
      child: ListView(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                logo,
                fit: BoxFit.fill,
                height: 120,
                width: 120,
              ),
            ),
            ...adminSideMenuItemRoutes
                .map((item) => AdminSideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!controller.isActive(item.name!)!) {
                        controller.changeActiveItemTo(item.name);
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
