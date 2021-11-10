import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController get to => Get.find();
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
      case 'MA Request':
        return _customIcon(Icons.list_outlined, itemName);
      case 'On Progress Request':
        return _customIcon(Icons.pending_outlined, itemName);
      case 'Releasing Area':
        return _customIcon(Icons.outbond_outlined, itemName);
      case 'Medical Assistance History':
        return _customIcon(Icons.history_outlined, itemName);
      default:
        return _customIcon(Icons.logout_outlined, itemName);
    }
  }

  Widget pswdHeadreturnIconFor(String itemName) {
    switch (itemName) {
      case 'Dashboard':
        return _customIcon(Icons.dashboard_outlined, itemName);
      case 'For Approval':
        return _customIcon(Icons.approval_sharp, itemName);
      case 'On Progress Request':
        return _customIcon(Icons.pending_outlined, itemName);
      case 'Releasing Area':
        return _customIcon(Icons.outbond_outlined, itemName);
      case 'Medical Assistance History':
        return _customIcon(Icons.history_outlined, itemName);
      default:
        return _customIcon(Icons.logout_outlined, itemName);
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
