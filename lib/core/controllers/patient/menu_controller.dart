import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientMenuController extends GetxController {
  final NavigationController navigationController = Get.find();
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
      case 'Consultation History':
      case 'Nakaraang Konsultasyon':
      case 'Karaang Konsultasyon':
        return _customIcon(Icons.history_outlined, itemName);
      case 'Current Consultation':
      case 'Kasalukuyang Konsultasyon':
      case 'Karon nga Konsultasyon':
        return _customIcon(Icons.chat_bubble_outline, itemName);
      case 'Change Language':
      case 'Baguhin ang Wika':
      case 'Ilisan ang Pinulongan':
        return _customIcon(Icons.translate_outlined, itemName);
      case 'App Info':
      case 'Impormasyon ng Aplikasyon':
      case 'Impormasyon sa aplikasyon':
        return _customIcon(Icons.info_outline_rounded, itemName);
      default:
        return _customIcon(Icons.history_outlined, itemName);
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
