import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading() {
  Get.defaultDialog(
      title: 'Loading...',
      content: CircularProgressIndicator(),
      barrierDismissible: false);
}

void showErrorDialog() {
  Get.defaultDialog(
    title: 'Error Occurred',
    textConfirm: 'Okay',
  );
}

void dismissDialog() {
  Get.back();
}
