import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveChatScreen extends StatelessWidget {
  static ConsController consController = Get.find();
  final fetchedPrescription = consController.consultation.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(fetchedPrescription!.age!),
      ),
    );
  }
}
