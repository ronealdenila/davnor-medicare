import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/patient_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';

class SelectQueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           verticalSpace20,
             Text(
              'Select to view your queue ',
              style: subtitle20Medium
            ),
            verticalSpace20,
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 230,
                height: 70,
                child: PCustomButton(
                  onTap: () {},
                  text: 'CONSULTATION',
                  buttonColor: verySoftBlueColor[80],
              ),
            ),
            ),
            verticalSpace25,
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 230,
                height: 70,
                child: PCustomButton(
                  onTap: () {},
                  text: 'PSWD MA',
                  buttonColor: verySoftBlueColor[80],
                ),
              ),
            )    
          ]),
      ),
    );
  }
}