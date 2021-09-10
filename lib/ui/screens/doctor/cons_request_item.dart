import 'package:davnor_medicare/core/controllers/doctor/doctor_home_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsRequestItemScreen extends StatelessWidget {
  static DoctorHomeController doctorHomeController = Get.find();
  final List<ConsultationModel> consultationList =
      doctorHomeController.consultations;
  final int index = Get.arguments as int;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            consultationList[index].fullName!,
            style: subtitle18Medium.copyWith(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.video_call_outlined),
              onPressed: () {},
            ),
            horizontalSpace5,
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {},
            ),
          ],
        ),
        //Todo: Make it a bubble chat
        body: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            Text(consultationList[index].description!),
          ],
        ),
      ),
    );
  }
}
