import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class AdminHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         AuthController.to.signOut();
        //       },
        //       icon: const Icon(Icons.logout),
        //     ),
        //   ],
        // ),
        // drawer: Drawer(
        //   child: TextButton(
        //     child: Text('Profile'),
        //     onPressed: () {
        //       //go to profile screen
        //     },
        //   ),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 1489,
                height: 323,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
              //Obx(()=>
              Text(
                  // ignore: lines_longer_than_80_chars
                  'Hello ${authController.adminModel.value!.firstName} ${authController.adminModel.value!.lastName}'),
              Text('Hello ${authController.userRole}'),
            ],
          ),
        ),
      ),
    );
  }
}
