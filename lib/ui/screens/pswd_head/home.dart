import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/controller/attached_photos_controller.dart';

class PSWDHeadHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final AttachedPhotosController pswdController =
      Get.put(AttachedPhotosController());

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
          child: TextButton(
            onPressed: () {
              //go to profile screen
            },
            child: const Text('Profile'),
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
