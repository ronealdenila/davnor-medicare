import 'package:davnor_medicare/ui/screens/patient/queue_cons.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/patient_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectQueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {},
        color: Colors.black,
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          verticalSpace20,
          Text('Select to view your queue ', style: subtitle20Medium),
          verticalSpace20,
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 230,
              height: 70,
              child: PCustomButton(
                onTap: () {
                  Get.to(() => QueueConsScreen());
                },
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
                onTap: () {
                  Get.to(() => QueueMAScreen());
                },
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
