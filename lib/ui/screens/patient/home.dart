import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/screens/patient/profile.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcVerySoftBlueColor,
          actions: [
            IconButton(
              onPressed: () {
                AuthController.to.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        drawer: Drawer(
          child: TextButton(
            child: Text('Profile'),
            onPressed: () {
              Get.to(() => PatientProfileScreen());
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Obx(()=>
              Text(
                  'Hello ${controller.patientModel.value!.firstName} ${controller.patientModel.value!.lastName}'),
              Text('Hello ${controller.userRole}'),
            ],
          ),
        ),
      ),
    );
  }
}
