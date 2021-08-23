import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Patient Home Screen'),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          authController.signOut();
        },
      ),
    );
  }
}
