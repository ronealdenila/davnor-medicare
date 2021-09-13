import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';

class AdminHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: verySoftBlueColor,
        ),
        body: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: screenWidth(context),
                    height: screenHeightPercentage(context, percentage: .25),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ]),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: verySoftBlueColor,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
     //Obx(()=>
            // Text(
            //     // ignore: lines_longer_than_80_chars
            //     'Hello ${authController.adminModel.value!.firstName}'),
            // Text('Hello ${authController.userRole}'),