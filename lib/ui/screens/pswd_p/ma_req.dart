import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';

class MARequestScreen extends StatelessWidget {
  final String temp =
      'https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(temp, 'completed'),
              //request accepted transferred approved medReady completed
              screenButtons(),
              verticalSpace35,
            ],
          ),
        )));
  }
}

Widget screenButtons() {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    CustomButton(
      onTap: () async {},
      text: 'Accept',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
    horizontalSpace25,
    CustomButton(
      onTap: () async {},
      text: 'Decline',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
  ]);
}
