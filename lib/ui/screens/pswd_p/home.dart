import 'package:davnor_medicare/ui/screens/pswd_p/controller/pswd_controller.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class PSWDPersonnelHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  final PSWDController pswdController = Get.put(PSWDController());
  final fetchedData = authController.pswdModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: authController.signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  //go to profile screen
                },
                child: const Text('Profile'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => MARequestScreen());
                },
                child: const Text('Medical Assistance Request'),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello ${fetchedData!.firstName} ${fetchedData!.lastName}'),
              Text('Hello ${authController.userRole}'),
            ],
          ),
        ),
      ),
    );
  }
}
