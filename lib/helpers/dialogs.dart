import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading() {
  Get.defaultDialog(
      title: 'Loading...',
      content: const CircularProgressIndicator(),
      barrierDismissible: false);
}

void showErrorDialog() {
  Get.defaultDialog(
    title: 'Error Occurred',
    textConfirm: 'Okay',
  );
}

void showConfirmationDialog(
  String dialogTitle,
  String description,
  Function()? onYesAction,
  Function()? onNoAction,
) {
  Get.defaultDialog(
    title: dialogTitle,
    content: Text(description),
    textConfirm: 'Yes',
    textCancel: 'No',
    onConfirm: onYesAction,
    onCancel: onNoAction,
  );
}

void dismissDialog() {
  Get.back();
}


