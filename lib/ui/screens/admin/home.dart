import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';

class AdminHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  final fetchedData = authController.adminModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //APPBAR TOPNAV
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Expanded(
                child: Row(
                    //HI LOL
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context),
                        height:
                            screenHeightPercentage(context, percentage: .25),
                        decoration: BoxDecoration(
                            color: verySoftBlueColor[60],
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text('Hi Hoder'),
                      ),
                    ]),
              ),
              Expanded(
                //content
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: verySoftBlueColor,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.pink,
                              )), //left Colm
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width * .2,
                                      height: 359,
                                      color: Colors.red,
                                    ), //left colm
                                    Expanded(
                                      child: Container(
                                        height: 359,
                                        color: Colors.blue,
                                      ),
                                    ) //right colm
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.green,
                                  ),
                                ) //bottom colm
                              ],
                            ),
                          ), //right Colm
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
