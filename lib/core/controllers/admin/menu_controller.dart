import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMenuController extends GetxController {
  final RxString activeItem = 'Dashboard'.obs;

  RxString hoverItem = ''.obs;

  bool? isHovering(String itemName) => hoverItem.value == itemName;

  bool? isActive(String itemName) => activeItem.value == itemName;

  RxString get changeActiveItemTo => activeItem;
  set changeActiveItemTo(RxString itemName) =>
      activeItem.value = itemName.value;

  void onHover(String itemName) {
    if (!isActive(itemName)!) hoverItem.value = itemName;
  }

  void controllerOneMethod() {
    return;
  }

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case 'Dashboard':
        return _customIcon(Icons.dashboard_outlined, itemName);
      case 'List Of Doctors':
        return _customIcon(Icons.list_outlined, itemName);
      case 'List of PSWD Personnel':
        return _customIcon(Icons.list_outlined, itemName);
      case 'Verification Requests':
        return _customIcon(Icons.list_outlined, itemName);
      case 'Disabled Doctors':
        return _customIcon(Icons.list_outlined, itemName);
      case 'Disabled PSWD Personnel':
        return _customIcon(Icons.list_outlined, itemName);
      default:
        return _customIcon(Icons.verified_outlined, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)!) {
      return Icon(
        icon,
        size: 22,
        color: infoColor,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName)! ? infoColor : neutralColor[60],
    );
  }
}
