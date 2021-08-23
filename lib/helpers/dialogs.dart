import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading(){
  Get.defaultDialog(
    title: "Loading...",
    content: CircularProgressIndicator(),
    barrierDismissible: false
  );
}

showErrorDialog(){
  Get.defaultDialog(
    title: 'Error Occurred',
    textConfirm: 'Okay',
  );
}

dismissDialog(){
  Get.back();
}