import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('sample'),
                  ],
                ),
              ),
            ));
  }
}
