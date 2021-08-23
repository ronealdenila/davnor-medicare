import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class PSWDHeadHomeScreen extends StatelessWidget {
  static AuthController to = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
              //go to profile screen
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Hello ${to.userModel.value!.firstName} ${to.userModel.value!.lastName}'),
              Text('Hello ${to.userRole}'),
            ],
          ),
        ),
      ),
    );
  }
}
